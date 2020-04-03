- [Membres du groupe](#membres-du-groupe)
- [Projet NA17 : Résilience (Groupe 3 P20)](#projet-na17--r%c3%a9silience-groupe-3-p20)
  - [Description](#description)
    - [Fonctions spécialisées](#fonctions-sp%c3%a9cialis%c3%a9es)
- [Livrables](#livrables)
  - [NDC](#ndc)
  - [Modèle UML (MCD)](#mod%c3%a8le-uml-mcd)
  - [MLD relationnel](#mld-relationnel)
  - [BDD : tables et vues, données de test, questions attendues (vues)](#bdd--tables-et-vues-donn%c3%a9es-de-test-questions-attendues-vues)
  - [Application Python](#application-python)
- [Remarques sur la v1 du projet](#remarques-sur-la-v1-du-projet)
  
# Membres du groupe
- Anaël Lacour
- Ombeline Lheureux 
- Pascal Quach
# Projet NA17 : Résilience (Groupe 3 P20)
## Description 
Le projet Résilience a pour objectif de mettre en réseau des personnes et des communautés dans une logique d'entre-aide.

Le projet permettra librement à chacune et chacun de s'ajouter à la base de données et de créer des communautés. Les personnes peuvent par ailleurs déclarer faire partie de communautés et/ou avoir des liens avec d'autres personnes. Les communautés peuvent déclarer avoir des liens avec d'autres communautés. Les liens sont unidirectionnels et portent une description. Par exemple : Alice déclare un lien vers Bob, avec pour description Bob est mon voisin.

Toute personne membre d'une communauté peut administrer toutes les informations de cette communauté, il peut agir dans la base en tant que "la communauté".

Une personne peut s'opposer à la présence d'une autre personne dans la communauté. Si plus de la moitié des membres de la communauté est opposé à la présence d'une autre personne, alors celle-ci ne fait plus partie de la communauté.

La base contient des savoir-faire. Chacun peut ajouter un savoir-faire. Chaque personne ou communauté peut déclarer posséder un savoir-faire, avec un certain degré (de 1 à 5).

Chacun peut proposer des services (qui peuvent être en lien avec ces savoir-faire). Ces services sont proposés : sans-contre partie ; en contre partie d'un autre service identifié, ou non identifié (à discuter) ; commercialement (contre une somme en monnaie Ğ1 https://fr.wikipedia.org/wiki/%C4%9E1). Les personnes et communauté possèdent éventuellement des comptes en Ğ1, on stocke dans la base la liste de leurs clés publiques.

Les personnes et communauté peuvent s'échanger des messages. Un message est la propriété intégrale de son expéditeur. Il s'adresse à un expéditeur et peut faire référence à un autre message.

Les personnes peuvent se localiser avec des coordonnées géographiques sous un format du type 49.41957, 2.82377. On sera capable de produire un lien du type : https://www.openstreetmap.org/#map=17/49.41957/2.82243 (où 17 est ici le niveau de zoom).
### Fonctions spécialisées
On proposera au moins les trois vues suivantes :

1. Vue communauté : 

2. Vue message : permet de visualiser chaque message en ajoutant l'identifiant du message d'origine lorsque le message s'inscrit dans un fil historique. Par exemple si C → B → A alors on veut voir la référence à A lorsqu'on affiche C.

3. Vue proches : permet de visualiser les communautés et personnes proches de chaque personne et communauté (à une distance inférieure à 1km)

# Livrables
## NDC
1. Rendu au format markdown.
2. [Note de clarification](NDC.md) ou [version web](NDC.html)
## Modèle UML (MCD)
  1. Rendu au format plantuml.
  2. [Modèle UML](modele.uml).
   > Le rendu graphviz n'est pas parfait. Il faut se référer au fichier texte.
## MLD relationnel
1. Rendu au format plain text.
2. [MLD relationnel](MLD%20relationnel.txt)
## BDD : tables et vues, données de test, questions attendues (vues)
1. Instructions de construction de la BDD en SQL
2. Jeu de test
## Application Python
1. Rendu du code source d'une application implémentant le projet.
2. Plus de détails à venir.

# Remarques sur la v1 du projet 
1. Le délai étant de conception et implémentation étant relativement court, on s'efforcera de mettre place les fonctionnalités essentielles. C'est-à-dire nécessaires au fonctionnement de l'application, qui doit répondre aux besoins établis. 
2.  Cependant, certains concepts et domaines de priorité secondaires seront abordés si seulement le temps est suffisant. Ces fonctionnalités correspondent notamment à la gestion du cycle de vie des données, au respect du RGPD, les conditions générales d'utilisation (CGU), etc. La facilité d'implémentation ultérieure de ces fonctionnalités justifient le délai dans leur traitement.