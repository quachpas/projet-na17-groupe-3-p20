SET search_path TO resilience;
/* INITIALISATION */
DROP TYPE IF EXISTS type_user CASCADE;
DROP TYPE IF EXISTS type_service CASCADE;
DROP TYPE IF EXISTS genre_service CASCADE;
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS person CASCADE;
DROP TABLE IF EXISTS community CASCADE;
DROP TABLE IF EXISTS users_link CASCADE;
DROP TABLE IF EXISTS account CASCADE;
DROP TABLE IF EXISTS skill CASCADE;
DROP TABLE IF EXISTS users_skill CASCADE;
DROP TABLE IF EXISTS membership_declaration CASCADE;
DROP TABLE IF EXISTS membership_opposition CASCADE;
DROP TABLE IF EXISTS conversation CASCADE;
DROP TABLE IF EXISTS conversation_participant CASCADE;
DROP TABLE IF EXISTS messages CASCADE;
DROP TABLE IF EXISTS messages_reference CASCADE;
DROP TABLE IF EXISTS service CASCADE;
DROP TABLE IF EXISTS service_skills CASCADE;
DROP TABLE IF EXISTS service_doers CASCADE;
DROP VIEW IF EXISTS view_service_doers CASCADE;
DROP VIEW IF EXISTS view_community CASCADE;
DROP VIEW IF EXISTS view_message CASCADE;
DROP VIEW IF EXISTS view_nearby CASCADE;

/* TABLES */
CREATE TYPE type_user AS ENUM ('P', 'C');
CREATE TYPE genre_service AS ENUM('O', 'D');
CREATE TYPE type_service AS ENUM('WC', 'WOC', 'C');


CREATE TABLE users(
    user_id BIGSERIAL,
    user_longitude NUMERIC (1000, 5) CHECK(user_longitude > -180.00000 AND user_longitude < 180.00000),
	user_latitude NUMERIC (1000, 5) CHECK(user_latitude > -90.00000 AND user_latitude < 90.00000),
	user_zoom INTEGER CHECK(user_zoom >= 0 AND user_zoom <= 18),
	user_type type_user NOT NULL, 
	PRIMARY KEY (user_id)
);

CREATE TABLE person(
	person_username VARCHAR(30) UNIQUE NOT NULL,
	person_fname VARCHAR(30) NOT NULL,
	person_lname VARCHAR(30) NOT NULL,
	person_birth_date DATE NOT NULL CHECK(person_birth_date < CURRENT_DATE), /* fonctionne si on change CURRENT_DATE par un string */
	person_hashed_pwd VARCHAR(60) UNIQUE NOT NULL,
	person_id INTEGER,
	PRIMARY KEY (person_id),
	FOREIGN KEY (person_id) REFERENCES users(user_id)
);

CREATE TABLE community(
	community_name VARCHAR (50) UNIQUE NOT NULL,
	community_description TEXT,
	community_creation_date DATE NOT NULL,
	community_id INTEGER,
	PRIMARY KEY (community_id),
	FOREIGN KEY (community_id) REFERENCES users(user_id)
);

CREATE TABLE users_link(
    description TEXT NOT NULL,
    sender INTEGER NOT NULL,
    receiver INTEGER NOT NULL,
    sender_type type_user NOT NULL,
    receiver_type type_user NOT NULL,
	PRIMARY KEY (sender, receiver),
    FOREIGN KEY (sender) REFERENCES users(user_id),
    FOREIGN KEY (receiver) REFERENCES users(user_id),
    CHECK (sender_type = receiver_type)
);


CREATE TABLE account(
	account_id BIGSERIAL,
	account_pk VARCHAR(256) UNIQUE NOT NULL,
	account_owner INTEGER NOT NULL,
	PRIMARY KEY (account_id),
	FOREIGN KEY (account_owner) REFERENCES users(user_id)
);

CREATE TABLE skill(
    skill_name VARCHAR(30),
	PRIMARY KEY (skill_name)
);

CREATE TABLE users_skill(
    degree INTEGER CHECK(degree >= 1 AND degree <= 5) NOT NULL,
    skill VARCHAR(30) NOT NULL,
    skill_holder INTEGER NOT NULL,
	PRIMARY KEY (skill, skill_holder),
    FOREIGN KEY (skill) REFERENCES skill (skill_name),
    FOREIGN KEY (skill_holder) REFERENCES users(user_id)  
);


CREATE TABLE membership_declaration(
    join_date DATE NOT NULL DEFAULT CURRENT_DATE,
    validity BOOLEAN NOT NULL DEFAULT TRUE,
    person INTEGER NOT NULL,
    community INTEGER NOT NULL,
	PRIMARY KEY(person, community),
    FOREIGN KEY (person) REFERENCES person(person_id),
    FOREIGN KEY (community) REFERENCES community(community_id)
);

CREATE TABLE membership_opposition(
    opponent INTEGER,
    person INTEGER,
    community INTEGER,
	PRIMARY KEY(opponent, person, community),
    FOREIGN KEY (opponent) REFERENCES person(person_id),
    FOREIGN KEY (person) REFERENCES person(person_id),
    FOREIGN KEY (community) REFERENCES community(community_id)
);
/* On devra utiliser un trigger pour modifier ou non les bools de validité à chaque fois que l'effectif d'une communauté change. HORS PROGRAMME*/

CREATE TABLE messages (
    message_id BIGSERIAL,
    message_conversation INTEGER,
    message_creation_date DATE NOT NULL DEFAULT CURRENT_DATE,
    message_sender INTEGER NOT NULL,
    message_content VARCHAR NOT NULL,
	PRIMARY KEY(message_id),
    FOREIGN KEY (message_sender) REFERENCES users(user_id)   
);

CREATE TABLE conversation(
    conversation_id BIGSERIAL PRIMARY KEY,
    conversation_last_message INTEGER DEFAULT NULL,
    FOREIGN KEY (conversation_last_message) REFERENCES messages(message_id)
);

ALTER TABLE messages 
ADD CONSTRAINT fk_message_conversation_conversation_id
FOREIGN KEY (message_conversation) REFERENCES conversation(conversation_id);

CREATE TABLE conversation_participant(
    participant INTEGER,
    conversation INTEGER,
	PRIMARY KEY (participant, conversation),
    FOREIGN KEY (participant) REFERENCES users(user_id),
    FOREIGN KEY (conversation) REFERENCES conversation(conversation_id)    
);

CREATE TABLE messages_reference(
    referrer INTEGER,
    referenced INTEGER,
	PRIMARY KEY(referrer, referenced),
    FOREIGN KEY (referrer) REFERENCES messages(message_id),
    FOREIGN KEY (referenced) REFERENCES messages(message_id)    
);

CREATE TABLE service(
    service_genre genre_service NOT NULL,
    service_name VARCHAR(30) NOT NULL,
    service_description TEXT NOT NULL,
    service_max_number INTEGER NOT NULL,
    service_publication_date DATE NOT NULL DEFAULT CURRENT_DATE,
    service_sum NUMERIC(1000, 2),
    service_consideration_description TEXT,
    service_consideration INTEGER,
    service_type type_service NOT NULL,
    service_id BIGSERIAL,
    service_author INTEGER NOT NULL,
    CHECK(service_type = 'WOC' OR service_type = 'WC' OR service_type = 'C'),
	PRIMARY KEY (service_id),
    FOREIGN KEY (service_author) REFERENCES users(user_id),
    FOREIGN KEY (service_consideration) REFERENCES service(service_id)
);

CREATE OR REPLACE FUNCTION resilience.triggerService()
RETURNS trigger LANGUAGE plpgsql
AS 
$BODY$
BEGIN 
IF (NEW.service_type = 'WC' 
	AND NOT(((NEW.service_consideration IS NOT NULL 
		  	 AND NEW.service_consideration_description IS NULL)
		 OR (NEW.service_consideration IS NULL 
			 AND NEW.service_consideration_description IS NOT NULL)) 
	AND NEW.service_sum IS NULL))
THEN RAISE EXCEPTION '
ErrorType WC : 
Consideration description : %,
Consideration (service_id) : %,
Sum : %,
', NEW.service_consideration_description, NEW.service_consideration, NEW.service_sum;
END IF;
IF (NEW.service_type='C' 
	AND (NEW.service_sum IS NULL 
	OR NEW.service_consideration IS NOT NULL 
	OR NEW.service_consideration_description IS NOT NULL))
THEN RAISE EXCEPTION '
ErrorType C : 
Consideration description : %,
Consideration (service_id) : %,
Sum : %,
', NEW.service_consideration_description, NEW.service_consideration, NEW.service_sum;
END IF;
IF (NEW.service_type = 'WOC' 
	AND (NEW.service_sum IS NOT NULL 
	OR NEW.service_consideration_description IS NOT NULL 
	OR NEW.service_consideration IS NOT NULL))
THEN RAISE EXCEPTION '
ErrorType WOC : 
Consideration description : %,
Consideration (service_id) : %,
Sum : %,
', NEW.service_consideration_description, NEW.service_consideration, NEW.service_sum;
END IF;
return NEW;
END
$BODY$;  
CREATE TRIGGER checktype BEFORE INSERT ON service FOR EACH ROW
EXECUTE PROCEDURE triggerService();

CREATE TABLE service_skills(
    skill VARCHAR(30),
    service_id INTEGER,
	PRIMARY KEY(skill, service_id),
    FOREIGN KEY (skill) REFERENCES skill(skill_name),
    FOREIGN KEY (service_id) REFERENCES service(service_id)    
);

CREATE TABLE service_doers(
    service_id INTEGER,
    user_id INTEGER,
	PRIMARY KEY (service_id, user_id),
    FOREIGN KEY (service_id) REFERENCES service(service_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)    
);

/* VUES */

CREATE VIEW view_service_doers AS
    SELECT S.service_id, R1.number_doers, S.service_max_number
    FROM (SELECT SD.service_id, COUNT(*) AS number_doers
    FROM service_doers SD
    GROUP BY SD.service_id
    ORDER BY SD.service_id) AS R1, service S
    WHERE R1.service_id = S.service_id;

CREATE VIEW view_community AS 
    SELECT MD.person, C.community_id, C.community_name, C.community_description, C.community_creation_date, 
        CASE WHEN MD.validity THEN 'membre' ELSE 'exclu' END AS Statut
    FROM community C, membership_declaration MD 
    WHERE MD.community=C.community_id
    GROUP BY MD.person, C.community_id, MD.community;

CREATE VIEW view_message AS
    SELECT original_message_id, original_message_content, referenced, message_content
    FROM (SELECT ME.message_id AS original_message_id, ME.message_content AS original_message_content, MR.referenced
        FROM messages ME
        LEFT JOIN messages_reference MR 
        ON ME.message_id = MR.referrer) AS R1
    JOIN messages ME
    ON R1.referenced = ME.message_id;


CREATE view view_nearby AS
    SELECT R4.user_id, R4.person_fname, R4.person_lname, R4.community_id, R4.community_name, R4.community_description FROM(
		SELECT R3A.user_id, R3A.person_fname, R3A.person_lname, R3A.community_id, R3A.community_name, R3A.community_description, R3A.user_longitude - R3B.user_longitudeB AS long_diff, R3A.user_latitude - R3B.user_latitudeB AS lat_diff
		FROM (SELECT R1.user_id, R1.person_fname, R1.person_lname, R2.community_id, R2.community_name, R2.community_description, R1.user_longitude, R1.user_latitude
			FROM (SELECT U.user_id, P.person_fname, P.person_lname, U.user_longitude, U.user_latitude
				FROM users U, person P
				WHERE U.user_id = P.person_id) AS R1
			FULL JOIN (SELECT U.user_id, CO.community_id, CO.community_name, CO.community_description, U.user_longitude, U.user_latitude
				FROM users U, community CO
				WHERE U.user_id = CO.community_id) AS R2
			ON R1.user_id = R2.user_id) AS R3A,  
			(SELECT *
			FROM (SELECT U.user_id
				FROM users U, person P
				WHERE U.user_id = P.person_id) AS R1
			FULL JOIN (SELECT U.user_id, U.user_longitude AS user_longitudeB, U.user_latitude AS user_latitudeB
				FROM users U, community CO
				WHERE U.user_id = CO.community_id) AS R2
			ON R1.user_id = R2.user_id) AS R3B) AS R4
    WHERE R4.long_diff >= -0.53902 AND R4.long_diff <= 0.53902 AND R4.lat_diff >= -0.53902 AND R4.lat_diff <= 0.53902;

    
    

/* JEU DE TEST*/

INSERT INTO users(user_longitude, user_latitude, user_zoom, user_type)
VALUES ('10.684', '-58.487', '16', 'P'),
 ('15.216', '-1.16874', '16', 'P'),
 ('-121.6549', '-15.4984', '16', 'P'),
 ('84.549', '-85.84', '16', 'P'),
('-18.984', '45.5498', '16', 'P'),
 ('178.546', '-55.5484', '16', 'P'),
 ('-0.14684', '-15.564', '16', 'C'),
 ('59.3549', '-21.9687', '16', 'C'),
 ('154.5687', '12.78', '16', 'C'),
 ('-38.4684', '-89.955', '16', 'C'),
('49.6078', '2.8178', '16', 'C'),/* Compi city */
('50.55','13.20','16','P'); 

INSERT INTO community(community_name, community_description, community_creation_date, community_id)
VALUES ('la Force', 'le bleu vous va mieux', '1999-01-06',7),
('LGBT', 'Tentative d''epuisement d''un non-lieu mondain', '1970-05-25',8),
('LIBERONS NOUS', 'Protégeons nos données personnelles.', '1987-02-15',9),
('Incroyables Digérables', 'Mouvement de réappropriation urbaine. Faisons tourner rond les ronds-points', '2019-03-14',10),
('NéoPicardie','Front de libération picard. Programme de rénovation agricole et d''integration culturelle.', '2016-11-12',11);

/* On a besoin du package pgcrypto pour utiliser la fonction gen_salt et crypt 
Le meilleur aurait été d'insérer de telle sorte le mdp : 
crypt('MDP_TEXTE', gen_salt('bf', 8))
Or, le package pgcrypto n'est pas présent sur le serveur pgsql fourni.
*/
INSERT INTO person(person_username, person_fname, person_lname, person_birth_date, person_hashed_pwd, person_id)
VALUES ('croziflette', 'Stephane', 'Croz', '1972-03-18', 'hsbcislove33', '1'),
('quiche', 'Frederic', 'Lordon', '1962-01-15', '*jourCouche*' ,2),
('jeiwhad', 'Jawad', 'Khalid', '1950-04-20', 'ouahçè_hb',3),
('STARCHY', 'Starch', 'Korn', '1995-02-12', 'motdepasse',4),
('JUNVD', 'Unoel', 'Plaei', '1957-06-10', '123456',5),
('loinu', 'Loiea', 'Nuhnaz', '1999-05-14', '65498' ,6),
('milleetunefeuilles','Freud','Sigmund','1856-05-06', '_hYstEriaA_' ,12) ;

INSERT INTO account (account_pk, account_owner)
VALUES ('MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC18mnzQF6O2HLGgJnVoG1HNH+ZHI9Yb1wXnxvcwmmnBSQvWb55lfK5kez01M2ay5C4A66mM7/IgrrQ9ZNZVRaeLiZHE+si7lVBj5zk46BDtKcfdEtKicR1PXbp65SzLDWWQ2QfqnW1ndjjxlxpM0pUqxXAk2swPFMXZUUDFZPSlQIDAQAB', '1'),
('MIGeMA0GCSqGSIb3DQEBAQUAA4GMADCBiAKBgHmlATCFg0b9TryhPMRPKfm4ZRlMGZHKE6NO46ukrY6tdj8TM3vi4xobVkNfPlVORaJWV/gtxjz/ysTxBDXw6gz4h3E1Vp1fkDmJrENvc01dQ0jrQP0UgalkMWRgh+E9lW0ob2nZhp9bf2qWF0ZjBdhQqWKFbaI95Dn6FwqcPhx/AgMBAAE=', '2'),
('MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCAgS7Ih2BpDWM0OFR8B1o4N7cGKguH/lUdKmtMQDmzY6aD4yKg/yOkMQXJZZuBEmrId7BrKKTRKcYnZf2Tl3VeIKh870xpI0XRiApCDiKVYww9LQDFePSD/LMt4l7+E7/JaheHlYMjI7SeZRfsGnkcFYabSVha4WU6814zxUE0kwIDAQAB', '3');

INSERT INTO users_link(description, sender, receiver, sender_type, receiver_type)
VALUES ('amitie', 1, 2, 'P', 'P'),
('ennemi', 2, 1, 'P', 'P'),
('commercial',7,8,'C','C'),
('partenaire', 9, 10, 'C', 'C'),
('partenaire', 10, 9, 'C', 'C');

INSERT INTO membership_declaration (join_date, validity, person, community)
VALUES ('2016-11-12',TRUE, 1, 9),
('1987-02-15',TRUE, 1, 11),
('2016-12-12',TRUE, 2, 11),
('1999-01-06',TRUE, 3, 7),
('2007-08-13',TRUE, 4, 7),
('2019-03-14',TRUE, 6, 10),
('1970-05-25',TRUE, 5,8),
('2019-07-21',FALSE, 3, 11),
('2015-02-27',TRUE, 3,8),
('2020-04-01',FALSE,4,10);

INSERT INTO membership_opposition (opponent, person, community)
VALUES (1,3,11),
(6,4,10),
(2,3,11);

INSERT INTO service (service_name, service_genre, service_description, service_max_number, service_publication_date, service_sum, service_consideration_description, service_consideration, service_type, service_author)
VALUES 
('Service 1', 'O', 'Service 1', '2', '2018-01-01', NULL, NULL, NULL, 'WOC', '1'),
('Service 2', 'D', 'Service 2', '2', '2018-01-01', '10.54', NULL, NULL, 'C', '2'),
('Service 3', 'D', 'Service 3', '2', '2018-01-01', NULL, 'Contrepartie 1 ou contrepartie 2', NULL, 'WC', '3'),
('Service 4', 'D', 'Service 4', '2', '2018-01-01', NULL, NULL, '1', 'WC', '1'),
('Cours equitation', 'O', 'pour dompter le cheval', '2', '2019-01-01', NULL, NULL, '1', 'WC', '1');


INSERT INTO service_doers (service_id, user_id)
VALUES ('4', '1');

INSERT INTO skill(skill_name) 
VALUES ('equitation'),
('escrime'),
('programmation'),
('peche'),
('medecine'),
('Judo'),
('mecanique'),
('nage'),
('anatomie'),
('musique');

INSERT INTO service_skills (skill,service_id)
VALUES('equitation', 5);

INSERT INTO users_skill(degree, skill, skill_holder)
VALUES(5, 'equitation', 1),
(3, 'equitation', 3),
(2, 'musique', 3);

INSERT INTO conversation (conversation_last_message)
VALUES (NULL), (NULL);

INSERT INTO conversation_participant(participant, conversation)
VALUES ('1', '1'), ('2', '1'), ('3', '2'), ('4', '2');

INSERT INTO messages (message_conversation, message_creation_date, message_sender, message_content)
VALUES ('1', '2000-01-01', '1', 'Coucou. Conversation 1'),
('2', '2000-02-02', '3', 'Coucou. Conversation 2'),
('2', '2000-02-03', '4', 'Coucou. Réponse 1 Conversation 2'),
('2', '2000-02-04', '3', 'Coucou. Réponse 2 Conversation 2');

UPDATE conversation
SET conversation_last_message = '1'
WHERE conversation_id = '1';

UPDATE conversation
SET conversation_last_message = '4'
WHERE conversation_id = '2';

INSERT INTO messages_reference (referrer, referenced)
VALUES ('3', '2'), ('2', '1');

/* DONNEES INVALIDES */
/*INSERT INTO service (service_name, service_genre, service_description, service_max_number, service_publication_date, service_sum, service_consideration_description, service_consideration, service_type, service_author)
VALUES 
('Tondre la pelouse', 'O', 'elle est longue', '2', '2018-01-01', NULL, NULL, NULL, 'C', '1');*/