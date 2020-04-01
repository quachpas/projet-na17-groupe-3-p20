- [Note de clarification du reseau Resilience](#note-de-clarification-du-reseau-resilience)
  - [Feedback](#feedback)
  - [Avant-propos](#avant-propos)
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
    - [Services commercialisé](#services-commercialis%c3%a9)
    - [Service avec contre-partie](#service-avec-contre-partie)
    - [Service sans contre-partie](#service-sans-contre-partie)
    - [Remarques additionnelles](#remarques-additionnelles-4)
  - [Savoir-faire](#savoir-faire)
    - [Attributs](#attributs-4)
    - [Droits et restrictions](#droits-et-restrictions-4)
    - [Remarques additionnelles](#remarques-additionnelles-5)
  - [Transactions](#transactions)
  - [Comptes](#comptes)
    - [Attributs](#attributs-5)
    - [Droits et restrictions](#droits-et-restrictions-5)
  - [Messagerie (Messages)](#messagerie-messages)
    - [Attributs](#attributs-6)
    - [Droits et restrictions](#droits-et-restrictions-6)
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
## Communautés et personnes
Les personnes et les communautés possèdent éventuellement des comptes en Ğ1. On devra stocker leurs clés publiques.
### Personne (Utilisateur)
#### Attributs
1. Toute personne sera identifiée par son nom d'utilisateur. Deux personnes ne pourront pas choisir le même nom d'utilisateur.
2. Elle devra préciser son nom, prénom. Elle peut définir des détails divers liés à sa personne (âge, date de naissance, etc. ). 
3. S'il souhaite être capable de réinitialiser son mot de passe, l'utilisateur devra obligatoirement renseigner un email.
4. Les personnes peuvent se localiser avec des coordonnées géographiques définies par la longitude et la latitude. 
#### Méthodes
1. Concernant la localisation, on pourra produire un lien sur openstreetmap.org. Exemple : https://www.openstreetmap.org/#map=17/49.41957/2.82243 (où 17 est ici le niveau de zoom).
#### Droits et restrictions
1. Toute personne pourra créer sans restrictions des communautés.
2. Tout personne peut déclarer sans restrictions (unidirectionnellement)
   1. faire partie d'une communauté,
   2. avoir un lien avec d'autres personnes.
3. Les déclarations sont obligatoirements exécutées par l'utilisateur lui-même. Une personne B ne peut pas réaliser une déclaration pour une personne A.
4. Pour les utilisateurs âgés de moins de 15 ans, le consentement conjoint du mineur et du/des titulaires de l'autorité parentale devra être recueilli.
5. Pour les mineurs âgés de 15 ans et plus, comme le précise l'article 7-1 de la loi relative à la protection des données, le mineur peut consentir seul au traitement des données à caractère personnel.
#### Remarques additionnelles
1. On considèrera les coordonées géographiques comme un type de données à part comprenant la latitude, longitude et le zoom pour obtenir un lien. La latitude et la longitude seront obligatoirement spécifiés. Le zoom est facultatif.  
### Communautés
#### Attributs
1. Une communauté sera identifiée par son nom. Deux communautés ne pourront donc pas avoir le même nom.
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
1. Les membres d'une communauté peuvent s'opposer à la déclaration d'appartenance d'une personne autre qu'eux-même. Si plus de la moitié des membres s'oppose à sa présence, sa déclaration d'appartenance n'est plus valide. Négativement, si une personne ne fait plus partie d'une communauté, son vote d'opposition n'est plus valide (il sera supprimé).
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
1. Par défaut, un nouveau membre d'une communauté ne s'oppose pas à une déclaration d'appartenance valide. Par contre, il s'oppose automatiquement à une déclaration d'appartenance invalide.
> On souhaite se protéger d'un effet domino positif. C'est-à-dire que les déclarations d'appartenances invalides ne redeviennent pas valides en chaîne suite à l'arrivée d'un nouveau membre.
### Déclaration de lien
#### Attributs
1. On rappelle que les liens sont considérés comme unidirectionnels, c'est à dire d'un émetteur à un récepteur. 
2. Les liens comportent obligatoirement une description. 
#### Droits et restrictions
1. Les liens entre communautés ou entre personnes sont uniques. Il ne peut exister qu'un lien entre deux entités distinctes.
3. Les déclarations de liens peuvent uniquement se réaliser de personne à personne ou de communauté à communauté distinctes. La gestion des liens d'une communauté est laissé à la discrétion de ses membres.
4. L'entité réceptrice de la déclaration de lien peut décider de l'accepter ou non.
> Malgré qu'on souhaite que le lien soit unidirectionnel, on accordera au récepteur de la déclaration de lien un droit de regard dans le but de minimiser les abus. On ne souhaite pas qu'un utilisateur déclare des liens qui n'existent pas. 
4. Si une déclaration de lien est déclarée invalide, l'émetteur de la déclaration de lien ne pourra en aucun cas en émettre une autre.
> Cette restriction permet de protéger de l'abus des déclarations de lien. 
4. Si une déclaration de lien est invalide, l'émetteur de la déclaration de lien peut modifier la description.
> On laissera cependant la possibilité à l'émetteur de modifier sa déclaration de lien, si elle est utilisée avec de bonnes intentions. 
5. Si une déclaration de lien est invalide, le récepteur de la déclaration peut à tout moment choisir de modifier son statut et de la valider.
> Dans la continuité du droit n°4, si la description est modifiée, le récepteur doit être capable d'accepter la déclaration. 
6. Si une déclaration de lien est valide, l'émetteur de la déclaration peut à tout moment choisir de modifier son statut et de l'invalider. 
7. Si une déclaration de lien est valide, le récepteur ne peut pas modifier son statut.
> Le lien est unidirectionnel. Un lien de A vers B déclare publiquement que A est lié à B suivant la description. 
7. Si une déclaration de lien est valide, la description du lien est figée.
> Si l'émetteur souhaite modifier le lien, il doit d'abord l'invalider. 
#### Remarques additionnelles
3. Par défaut, aucun lien n'existe entre les entités de Résilience.
4. Si la déclaration de lien est validée, elle sera visible publiquement sur le profil de l'émetteur. Elle n'est pas visible sur le public du récepteur.
5. Si la déclaration de lien est invalidée, on garde le status quo. Aucun lien n'est affiché.
### Vue communauté
Elle permet à chaque personne d'avoir la liste des communautés auxquelles il déclare appartenir avec un booléen qui détermine si la personne est exclue ou non.
## Services
### Description
1. Pour faciliter l'échange de services et promouvoir l'interaction sociale, on considèrera qu'un service peut être proposé, ou demandé. Les utilisateurs ne sont pas dépendants de l'offre, mais explicitent également la demande. De même, la palette d'offres peut inspirer les utilisateurs quant aux compétences qu'ils estiment posséder.
2. Les services peuvent être publiés par n'importe quelle personne. 
3. Les services sont publiés soit sans-contre partie, soit avec contre-partie, soit commercialement contre une somme en Ğ1. 
### Attributs
1. Un service sera identifié 
### Services commercialisé
### Service avec contre-partie
1. Une personne ne pourra accéder aux services avec contre-partie commerciale si elle n'a pas de compte en Ğ1.
### Service sans contre-partie
### Remarques additionnelles
1. Au niveau de l'implémentation, un service avec contre-partie peut être lié avec un service sans contre-partie, un service commercialisé, ou un autre service avec contre-partie dans la mesure où tous ces services sont identifiés. Un service identifié est un service qui a été enregistré dans notre BDD. Un service (contre partie) non identifié(e) s'exprimerait sur le mode descriptif, par exemple pourrait y figurer plusieurs propositions. L'utilisateur serait alors soumis à un choix : par exemple, jardinage ou cours de danse. On le considèrera comme un champ de texte personalisé. 
2. Concrètement, un utilisateur crée un service A, dit avec contre-partie. La contre-partie associée est alors soit identifiée, soit non identifiée. On dit d'une contre-partie qu'elle est identifiée si l'utilisateur renseigne dans la base de données le service qu'il propose en échange. La contre-partie est non identifiée quand l'utilisateur décrit le(s) type(s) de service au(x)quel(s) il aimerait répondre (généralement correlé(s) aux savoir-faire qu'il possède).
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
2. On implémentera une vérification suffisament solide pour éviter les erreurs utilisateurs du type création de deux savoir-faire avec un  On se munira d'un correcteur orthographique. 
## Transactions

## Comptes
### Attributs
1. Un compte sera identifié par sa clé publique.
### Droits et restrictions
1. Un compte ne peut appartenir qu'à une communauté ou à une personne. Il n'y a pas de compte partagé entre deux entités.
2. On peut associer à une communauté ou à un membre plusieurs comptes à la fois.
## Messagerie (Messages)
Les personnes et communautés peuvent s'échanger des messages. L'échange de message peut se réaliser entre deux personnes, deux communautés, ou une communauté et une personne et inversement.
### Attributs
1. Un message est la propriété intégrale de son expéditeur. 
2. Un message sera identifié par son expéditeur, son destinataire et un timestamp.
3. Il s'adresse à un expéditeur et peut faire référence à un autre message.
### Droits et restrictions
1. Un message peut être supprimé et/ou modifié par son expéditeur.
### Vue message
On proposera la vue message qui permet de visualiser chaque message en ajoutant l'identifiant du message d'origine lorsque le message s'inscrit dans un fil historique. Par exemple si C → B → A alors on veut voir la référence à A lorsqu'on affiche C.
### Remarques additionnelles
1. Un utilisateur peut s'envoyer un message à lui-même. On pourra toujours trouver le message d'origine. 
> La vue message trouvera forcément un message d'origine. Effectivement, il ne peut pas exister de cycle. Un message ne peut pas faire référence à une message qui aurait été envoyé après lui ...




