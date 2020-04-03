- [Note de clarification du reseau Resilience](#note-de-clarification-du-reseau-resilience)
  - [Feedback](#feedback)
  - [Avant-propos](#avant-propos)
    - [Cycle de vie des données](#cycle-de-vie-des-donn%c3%a9es)
    - [Respect du RGPD](#respect-du-rgpd)
  - [Communautés et personnes](#communaut%c3%a9s-et-personnes)
    - [Personne (Utilisateur)](#personne-utilisateur)
      - [Attributs](#attributs)
      - [Méthodes](#m%c3%a9thodes)
      - [Droits et restrictions](#droits-et-restrictions)
      - [Remarques additionnelles](#remarques-additionnelles)
    - [Communautés](#communaut%c3%a9s)
      - [Attributs](#attributs-1)
      - [Droits et restrictions](#droits-et-restrictions-1)
      - [Remarques additionnelles](#remarques-additionnelles-1)
    - [Déclaration d'appartenance à une communauté](#d%c3%a9claration-dappartenance-%c3%a0-une-communaut%c3%a9)
      - [Droits et restrictions](#droits-et-restrictions-2)
      - [Remarques additionnelles](#remarques-additionnelles-2)
    - [Déclaration de lien](#d%c3%a9claration-de-lien)
      - [Attributs](#attributs-2)
      - [Droits et restrictions](#droits-et-restrictions-3)
      - [Remarques additionnelles](#remarques-additionnelles-3)
    - [Vue communauté](#vue-communaut%c3%a9)
  - [Services](#services)
    - [Description](#description)
    - [Attributs](#attributs-3)
    - [Droits et restrictions](#droits-et-restrictions-4)
    - [Services commercialisé](#services-commercialis%c3%a9)
    - [Service avec contre-partie](#service-avec-contre-partie)
    - [Service sans contre-partie](#service-sans-contre-partie)
    - [Remarques additionnelles](#remarques-additionnelles-4)
  - [Savoir-faire](#savoir-faire)
    - [Attributs](#attributs-4)
    - [Droits et restrictions](#droits-et-restrictions-5)
    - [Remarques additionnelles](#remarques-additionnelles-5)
  - [Transactions](#transactions)
  - [Comptes](#comptes)
    - [Attributs](#attributs-5)
    - [Droits et restrictions](#droits-et-restrictions-6)
  - [Transactions](#transactions-1)
  - [Système de messagerie](#syst%c3%a8me-de-messagerie)
    - [Conversation](#conversation)
      - [Attributs](#attributs-6)
      - [Droits et restrictions](#droits-et-restrictions-7)
    - [Messages](#messages)
      - [Attributs](#attributs-7)
      - [Droits et restrictions](#droits-et-restrictions-8)
    - [Vue message](#vue-message)
    - [Remarques additionnelles](#remarques-additionnelles-6)
# Note de clarification du reseau Resilience
## Feedback
- Vous avez fait un travail intéressant d'analyse, mais la présentation n'est pas très claire. Repartez plutôt d'une liste d'objets pour organiser ensuite vos hypothèses.
- On veut plutôt pouvoir utiliser la NDC pour faire notre UML sans avoir à se reporter à nouveau au CDC (ajoutez vos noms dans votre README)
## Avant-propos
Le réseau Résilience est composé de plusieurs parties :
- les communautés et les personnes,
- les services,
- les savoir-faire,
- les transactions (transactions et comptes),
- la messagerie.
On clarifiera successivement ces différentes parties de façon explicite, en détaillant les droits et les restrictions qui seront appliquées. Nous rajouterons également des élements pour résoudre les problèmes éventuels.
### Cycle de vie des données 
1. Selon les règlementations légales françaises, s'il devenait pertinent de les appliquer pour certaines de nos données, il faudra archiver ces données et les conserver pour une durée légale fixée. 
2. Les données non relatives à des données personnelles, qui sont supprimmées conceptuellement par les actions de l'utilisateur seront supprimés définitivement et immédiatement de la base de données. Aucun archivage ne sera effectué.
### Respect du RGPD
1. La durée de validité du consentement (au sens du RGPD) est porté à 13 mois maximum. Au-delà de ce délai, l'application devra de nouveau recueillir le consentement.
2. Par conséquent, la durée de vie des cookies et autres traceurs doit être limitée à 13 mois. 
3. Le droit à l'oubli spécifie qu'au bout de 36 mois d'inactivité, les données personnelles d'un utilisateur doivent être supprimés de notre base de données. La suppression est définitive et ne correspond pas à un archivage des données. 
4. Pour les utilisateurs âgés de moins de 15 ans, le consentement conjoint du mineur et du/des titulaires de l'autorité parentale devra être recueilli.
5. Pour les mineurs âgés de 15 ans et plus, comme le précise l'article 7-1 de la loi relative à la protection des données, le mineur peut consentir seul au traitement des données à caractère personnel.
6. Les données personnelles d'un utilisateur doivent être à tout moment, rectifiable, effaçables, et restituables. Le délai pour effectuer ces actions suite à la demande est un mois. 
## Communautés et personnes
Les personnes et les communautés possèdent éventuellement des comptes en Ğ1. On devra stocker leurs clés publiques.
### Personne (Utilisateur)
#### Attributs
1. Toute personne sera identifiée par une clé artificielle. 
> Le choix de la clé artificielle relève de critères de performances et d'extensibilité. Il sera plus facile d'effectuer des changements si l'utilisateur est identifiée par une clé primaire séquentielle. Il est également plus rapide de chercher un contenu léger (un octet), qu'une chaîne de caractères. 
2. Un utilisateur devra spécifier un nom d'utilisateur. Deux personnes ne pourront pas choisir le même nom d'utilisateur.
3. Elle devra préciser son nom, prénom. Elle peut définir des détails divers liés à sa personne (âge, date de naissance, etc.). 
4. S'il souhaite être capable de réinitialiser son mot de passe, l'utilisateur devra obligatoirement renseigner un email.
5. Les personnes peuvent se localiser avec des coordonnées géographiques définies par la longitude et la latitude.
#### Méthodes
1. Concernant la localisation, on pourra produire un lien sur openstreetmap.org. Exemple : https://www.openstreetmap.org/#map=17/49.41957/2.82243 (où 17 est ici le niveau de zoom). 
> Le niveau de zoom est compris entre 0 et 18  : https://wiki.openstreetmap.org/wiki/FR:Zoom_levels.
#### Droits et restrictions
1. Toute personne pourra créer sans restrictions des communautés.
2. Tout personne peut déclarer sans restrictions (unidirectionnellement)
   1. faire partie d'une communauté,
   2. avoir un lien avec d'autres personnes.
3. Les déclarations sont obligatoirements exécutées par l'utilisateur lui-même. Une personne B ne peut pas réaliser une déclaration pour une personne A.
#### Remarques additionnelles
1. On considèrera les coordonées géographiques comme un type de données à part comprenant la latitude, longitude et le zoom pour obtenir un lien. La latitude et la longitude seront obligatoirement spécifiés. Le zoom est facultatif.  
2. On implémentera si possible une forte sécurité au niveau du mot de passe utilisateur, c'est-à-dire qu'on l'encryptera.
   1. On se munira d'un sel pour contrecarrer l'utilisation de *rainbow tables*. Le sel devra être généré en utilisant un [CSPRNG](https://en.wikipedia.org/wiki/Cryptographically_secure_pseudorandom_number_generator). Le sel est unique pour chaque utilisateur et son mot de passe. Il sera regénéré si l'utilisateur change de mot de passe.
   2. On utilisera une fonction d'étirement de clé pour se protéger contre les attaques par force brute. Par exemple, PBKDF2.
   3. Le mot de passe sera enregistré encrypté dans la base de données. 
   4. Le processus de connexion se déroulera au mieux ainsi :
      1. L'utilisateur rentre son mot de passe côté client. Le mot de passe naturel est envoyé au serveur via HTTPS (sécurisé). 
      2. Le serveur encrypte le mot de passe en utilisant le sel et le nombre d'itérations et le compare au mot de passe encrypté sur le serveur. 
      3. Le serveur valide ou non la connexion du client.
### Communautés
#### Attributs
1. Une communauté sera identifiée par une clé artificielle.
> Le choix de la clé artificielle correspond à des critères d'extensibilité et de performances, similaires au choix d'utiliser une clé artificielle pour un utilisateur. On veut par exemple se laisser la possibilité de renommer une communauté. Ce n'est pas possible si le nom d'une communauté est immuable.
2. Une communauté est muni d'un nom. Deux communautés ne pourront donc pas avoir le même nom.
3. On enregistrera la date de création d'une communauté.
#### Droits et restrictions
1. Toute communauté pourra déclarer un lien unidirectionnel avec une autre communauté.
2. L'administration d'une communauté est déléguée à tous les membres de la communauté. Ils ont tous les mêmes droits et accès.
#### Remarques additionnelles
1. Une communauté ne peut pas exister sans membre. Il en faut au minimum un. Le premier membre d'une communauté sera donc celui qui l'a crée. 
2. Une communauté sans membre n'existe donc pas. Si le dernier membre quitte la communauté, toutes ses données associées seront supprimées immédiatement.
3. On avertira éventuellement le dernier membre d'une communauté souhaitant la quitter des conséquences de son action. 
### Déclaration d'appartenance à une communauté
#### Droits et restrictions
1. Les déclarations d'appartenance entre une personne et une communauté sont uniques. 
2. Les membres d'une communauté peuvent s'opposer à la déclaration d'appartenance d'une personne autre qu'eux-même. Si plus de la moitié des membres s'oppose à sa présence, sa déclaration d'appartenance n'est plus valide. Négativement, si une personne ne fait plus partie d'une communauté, son vote d'opposition n'est plus valide (il sera supprimé).
3. En aucun cas, une personne ne pourra décider du vote d'opposition d'une autre personne.
#### Remarques additionnelles
1. La déclaration d'appartenance d'un membre à une communauté est actualisée à chaque fois que l'effectif de la communauté varie, c'est-à-dire quand un membre quitte (de gré ou de force) une communauté ou qu'un nouveau membre rejoint la communauté.
2. On considère le critère d'opposition comme suit : pour qu'un membre soit exclu d'une communauté, il faut que la majorité du reste de la communauté s'oppose à sa déclaration d'appartenance. On passe à la majorité quand on atteint la partie entière supérieure de la moitié de l'effectif moins un. 
> Critère : Ent((effectif-1)/2) 
3. Dès lors que la déclaration d'appartenance est invalide, la personne est exclue mais la relation entre personne et communauté est conservée.
> Ceci permet de gérer l'abus de déclarations d'appartenance.
4. Un effet "domino" négatif sera accepté. Par exemple, dans une communauté de 8 personnes (le palier est donc à Ent((8-1)/2)=Ent(3,5)=4), si une personne A avait 3 voix d'oppositions contre elle et que la communauté perd un membre (qui ne s'opposait pas), alors A sera éjecté de la communauté car Ent((7-1)/2)=3.
5. L'ordre d'invalidation est significatif dans l'application de l'effet domino négatif. Dans un cas plus complexe, où les oppositions "se croisent", c'est-à-dire que les membres s'opposent mutuellement, on choisira toujours d'appliquer la mise à jour de l'appartenance dans l'ordre croissant d'ancienneté. Les membres les plus récents seront donc exclus en premier. 
6. Par exemple, on peut se trouver dans le cas où deux membres s'opposent mutuellement. On y arrive à cause de l'effet domino négatif. Quoi qu'il en soit, le critère de sélection sera donc l'ancienneté, et le membre le plus récent sera exclu de la communauté.
> Par définition, cet effet domino a une fin quand il ne reste plus qu'un membre. Il ne peut effectivement pas s'opposer lui-même.
7. Par défaut, un nouveau membre d'une communauté ne s'oppose pas à une déclaration d'appartenance valide. Par contre, il s'oppose automatiquement à une déclaration d'appartenance invalide.
> On souhaite se protéger d'un effet domino positif. C'est-à-dire que les déclarations d'appartenances invalides ne redeviennent pas valides en chaîne suite à l'arrivée d'un nouveau membre.
### Déclaration de lien
#### Attributs
1. On rappelle que les liens sont considérés comme unidirectionnels, c'est à dire d'un émetteur à un récepteur.
2. Les liens comportent obligatoirement une description.
#### Droits et restrictions
1. Les liens entre communautés ou entre personnes sont uniques. Il ne peut exister qu'un lien entre deux entités distinctes de même type.
2. Les déclarations de liens peuvent uniquement se réaliser de personne à personne ou de communauté à communauté distinctes. La gestion des liens d'une communauté est laissé à la discrétion de ses membres.
3. L'entité réceptrice de la déclaration de lien peut décider de l'accepter ou non.
> Malgré qu'on souhaite que le lien soit unidirectionnel, on accordera au récepteur de la déclaration de lien un droit de regard dans le but de minimiser les abus. On ne souhaite pas qu'un utilisateur déclare des liens qui n'existent pas. 
4. Si une déclaration de lien est déclarée invalide, l'émetteur de la déclaration de lien ne pourra en aucun cas en émettre une autre.
> Cette restriction permet de protéger de l'abus des déclarations de lien. 
5. Si une déclaration de lien est invalide, l'émetteur de la déclaration de lien peut modifier la description.
> On laissera cependant la possibilité à l'émetteur de modifier sa déclaration de lien, si elle est utilisée avec de bonnes intentions. 
6. Si une déclaration de lien est invalide, le récepteur de la déclaration peut à tout moment choisir de modifier son statut et de la valider.
> Dans la continuité du droit n°4, si la description est modifiée, le récepteur doit être capable d'accepter la déclaration. 
7. Si une déclaration de lien est valide, l'émetteur de la déclaration peut à tout moment choisir de modifier son statut et de l'invalider. 
8. Si une déclaration de lien est valide, le récepteur ne peut pas modifier son statut.
> Le lien est unidirectionnel. Un lien de A vers B déclare publiquement que A est lié à B suivant la description. 
9. Si une déclaration de lien est valide, la description du lien est figée.
> Si l'émetteur souhaite modifier le lien, il doit d'abord l'invalider. 
#### Remarques additionnelles
1. Par défaut, aucun lien n'existe entre les entités de Résilience.
2. Si la déclaration de lien est validée, elle sera visible publiquement sur le profil de l'émetteur. Elle n'est pas visible sur le public du récepteur.
3. Si la déclaration de lien est invalidée, on garde le status quo. Aucun lien n'est affiché.
### Vue communauté
Elle permet à chaque personne d'avoir la liste des communautés auxquelles il déclare appartenir avec un booléen qui détermine si la personne est exclue ou non.
## Services
### Description
Pour faciliter l'échange de services et promouvoir l'interaction sociale, on considèrera qu'un service peut être proposé, ou demandé. Les utilisateurs ne sont pas dépendants de l'offre, mais explicitent également la demande. De même, la palette d'offres peut inspirer les utilisateurs quant aux compétences qu'ils estiment posséder.
Le service est une classe abstraite. 
### Attributs
1. Le service possèdera un nom, une description, une date de publication, ou une contre-partie définie plus bas.
2. On enregistrera l'auteur du service. Il peut être une communauté, ou une personne.
3. Un service sera identifié par une clé artificielle, comme il est très difficile de trouver une clé naturelle. On aurait pu proposer d'identifier le service avec le nom, l'auteur, et la date de publication.
### Droits et restrictions
1. Les services peuvent être publiés par n'importe quelle personne. 
2. Les services ne peuvent être modifiés que par leur auteur. 
3. Les services sont publiés soit sans-contre partie, soit avec contre-partie, soit commercialement contre une somme en Ğ1. 
4. Les services ne pourront être réalisées que par un unique individu. 
5. Les individus exclus d'une communauté A ne sont pas restreints de réaliser un service pour la communauté A.
6. Un service ne peut être que d'un type à la fois.
7. Un service ne peut être la contre-partie que d'un unique service avec contre-partie. 
> C'est-à-dire qu'on ne pourra par exemple proposer la réalisation d'un service en contre-partie d'un autre qu'une fois. 
### Services commercialisé
1. Un montant sera obligatoirement précisé.
2. Une personne ne pourra accéder aux services avec contre-partie commerciale si elle n'a pas de compte en Ğ1.
### Service avec contre-partie
1. Le service avec contre-partie peut se baser sur le troc. La contre-partie sera éventuellement décrite textuellement.
2. La contre-partie d'un service peut-être la réalisation d'un autre service. 
### Service sans contre-partie
1. Le service est proposé/demandé sans rien en échange, il est entièrement bénévole.
### Remarques additionnelles
1. Au niveau de l'implémentation, un service avec contre-partie peut être lié avec un service sans contre-partie, un service commercialisé, ou un autre service avec contre-partie dans la mesure où tous ces services sont identifiés. Un service identifié est un service qui a été enregistré dans notre BDD. Un service (contre partie) non identifié(e) s'exprimerait sur le mode descriptif, par exemple pourrait y figurer plusieurs propositions. L'utilisateur serait alors soumis à un choix : par exemple, jardinage ou cours de danse. On le considèrera comme un champ de texte personalisé. 
2. Concrètement, un utilisateur crée un service A, dit avec contre-partie. La contre-partie associée est alors soit identifiée, soit non identifiée. On dit d'une contre-partie qu'elle est identifiée si l'utilisateur renseigne dans la base de données le service qu'il propose en échange. La contre-partie est non identifiée quand l'utilisateur décrit le(s) type(s) de service au(x)quel(s) il aimerait répondre (généralement correlé(s) aux savoir-faire qu'il possède).
3. Il est tout à fait possible que la contre-partie d'un service soit décrite comme une rémunération monétaire. Les utilisateurs sont libres de l'utilisation de Résilience. Même si ce type de service n'est pas censé être utilisé avec ces intentions en tête.
4. Si un individu se porte candidat à la réalisation d'un service, cela fait office de déclaration d'honneur. On avertira le candidat s'il n'a pas les savoir-faire, ou s'il n'a pas le degré de maîtrise suffisant. 
## Savoir-faire
### Attributs
1. Un savoir-faire est identifié par son nom. Deux savoir-faire ne peuvent pas avoir le même nom.
### Droits et restrictions
1. L'ajout de savoir-faire est géré par l'ensemble des membres de Résilience. Chacun peut en rajouter. 
2. Une personne ou une communauté peut déclarer posséder un savoir-faire. 
3. Une personne ne peut déclarer un savoir-faire que pour elle-même, ou pour les communautés auxquelles elle appartient par extension à la règle d'administration des communautés.
4. Les savoir-faire peuvent être possédés sans limites. Une personne et/ou une communauté peut posséder autant de savoir-faire qu'elle le souhaite.
### Remarques additionnelles
1. Il n'y aura aucune vérification de légitimité.
2. On implémentera une vérification suffisament solide pour éviter les erreurs utilisateurs du type création de deux savoir-faire avec un nom similaire. On se munira d'un correcteur orthographique. 
## Transactions
## Comptes
### Attributs
1. Un compte sera identifié par sa clé publique.
### Droits et restrictions
1. Un compte ne peut appartenir qu'à une communauté ou à une personne. Il n'y a pas de compte partagé entre deux entités.
2. On peut associer à une communauté ou à un membre plusieurs comptes à la fois.
## Transactions
Les transactions n'apparaissent en somme pas dans la base de données, vu qu'elles seront présentes dans les noeuds.
On pourra se munir de l'API de Césium pour prendre en charge les transactions. https://g1.duniter.fr/api/#/app/home.
## Système de messagerie
Les personnes et communautés peuvent s'échanger des messages. L'échange de message peut se réaliser entre deux personnes, deux communautés, ou une communauté et une personne et inversement.
> Par soucis d'extensibilité, on s'efforcera de mettre en place des relations permettant une conversation de groupe. 
### Conversation
Chaque conversation correspond à un ensemble de messages entre deux entités. C'est un historique des messages entre deux entités. Il n'existe que s'il existe des messages entre deux entités. 
> On se garde la possibilité d'étendre les conversations à plus de deux entités dans le futur.  
#### Attributs
1. Une conversation sera identifiée par une clé artificielle séquentielle dans un soucis de performances et d'extensibilité. 
2. Une conversation contiendra l'id du dernier message envoyé. Il faudra le mettre à jour dynamiquement.
> On pourra éventuellement stocker la date et heure à laquelle un participant a lu les messages d'une conversation.
#### Droits et restrictions
1. Une conversation ne peut pas être supprimée intégralement par un seul des deux partis. Il faudra l'accord des deux partis, car les messages sont la propriété inntégrale de leurs expéditeurs.
2. Un parti pourra choisir de supprimer uniquement tous les messages qu'il a envoyé.
### Messages
#### Attributs
1. Un message est muni d'un contenu, et d'une date de création.
2. Le message provient d'un expéditeur (utilisateur, ou communauté), 
3. On pourra faire référence à un autre message au sein d'une conversation. 
4. Un message sera identifié par une clé artificielle dans un soucis de performance et d'extensibilité.
> On aurait pu proposer d'identifier un message avec une clé naturelle telle que l'id de l'utilisateur, l'id de la conversation, et un timestamp du message. 
#### Droits et restrictions
1. Un message peut être supprimé et/ou modifié par son expéditeur.
2. Un message ne peut faire référence qu'à un seul autre message. Par contre, un message peut être référencé sans limites.
### Vue message
On proposera la vue message qui permet de visualiser chaque message en ajoutant l'identifiant du message d'origine lorsque le message s'inscrit dans un fil historique. Par exemple si C → B → A alors on veut voir la référence à A lorsqu'on affiche C.
### Remarques additionnelles
1. Un message est la propriété intégrale de son expéditeur. Il constitue une donnée à caractère personnelle.
2. Un utilisateur peut s'envoyer un message à lui-même. On pourra toujours trouver le message d'origine. 
> La vue message trouvera forcément un message d'origine. Effectivement, il ne peut pas exister de cycle. Un message ne peut pas faire référence à une message qui aurait été envoyé après lui ...
3. Au niveau de l'implémentation, on aura trois relations : conversations, participants, et message. La table participants est une table d'association pour savoir qui participe à une conversation. Elle ne serait pas nécessaire si on se restreignait à un système de messagerie en deux entités uniquement. Cependant, comme dit plus haut, par soucis d'extensibilité, on souhaite se faciliter la tâche si on change cette restriction ultérieurement.




