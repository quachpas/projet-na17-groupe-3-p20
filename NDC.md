# Note de clarification du reseau Resilience
## Analyse des besoins et clarification
1. On veut établir un réseau d'entraide entre des personnes et des communautés. 
2. Toute personne pourra sans restriction créer des communautés. 
3. Toute personne peut déclarer faire partie de communautés, ou avoir des liens avec d'autres personnes. Ces déclarations sont unidirectionnelles. Une personne pourra faire partie d'autant de communautés et avoir autant de liens qu'elle le souhaite. 
 Ces déclarations sont obligatoirement faites par la personne elle-même. Une autre personne ne peut pas "ajouter" une personne à une communauté.
4. L'administration d'une communauté est déléguée à tous les membres de la communauté. Ils ont tous les mêmes droits et accès.
5. Les membres d'une communauté peuvent s'opposer à la déclaration d'appartenance d'une personne autre qu'eux-même. Si plus de la moitié des membres s'oppose à sa présence, sa déclaration d'appartenance n'est plus valide. 
6. L'ajout de savoir-faire est géré par toutes les personnes. Chacun peut en rajouter. 
7. Les services peuvent être proposés par n'importe quelle personne. 
## Choix effectués 
1. Une communauté ne peut pas exister sans membre. Il en faut au minimum un : celui qui la crée. Une communauté sans membre n'existe donc pas. Si le dernier membre quitte la communauté, toutes ses données associées seront supprimées.
2. On considèrera les coordonées géographiques comme un type de données à part comprenant la latitude, longitude et le zoom pour obtenir un lien. 
3. Les savoir-faire peuvent être possédés sans limites. Une personne et/ou une communauté peut posséder autant de savoir-faire qu'ils le souhaitent. Il n'y aura aucune vérification de légitimité. 
4. Les liens entre communautés, entre personnes, et les déclarations d'appartenance entre une personne et une communauté sont uniques. 
5. La déclaration d'appartenance d'un membre à une communauté est actualisée à chaque fois que l'effectif de la communauté varie, c'est-à-dire quand un membre quitte une communauté ou qu'un nouveau membre rejoint la communauté.
6. On considère le critère d'opposition comme suit : pour qu'un membre soit exclu d'une communauté, il faut que la majorité du reste de la communauté s'oppose à sa déclaration d'appartenance. On passe à la majorité quand on atteint la partie entière supérieure de la moitié de l'effectif, moins un. 
7. Dès lors que la déclaration d'appartenance est invalide, la personne est exclue mais la relation entre personne et communauté est conservée. Ceci permet de gérer l'abus de déclarations d'appartenance à répétition.
8. Un effet "domino" sera accepté. Par exemple, dans une communauté de 8 personnes si une personne A avait 4 voix d'oppositions contre elle et que la communauté perd un membre (qui ne s'opposait pas), alors A sera éjecté de la communauté, et ainsi de suite tant que la règle est applicable. Par définition, cet effet domino a une fin. 
9. Par défaut, un nouveau membre d'une communauté ne s'oppose pas à une déclaration d'appartenance valide. Par contre, il s'oppose automatiquement à une déclaration d'appartenance invalide. Ainsi, on se protège de l'effet "domino" inverse. C'est-à-dire que les déclarations d'appartenances invalides ne redeviennent pas valides en chaîne suite à l'arrivée d'un nouveau membre.
10. Un compte ne peut appartenir qu'à une communauté ou à une personne, il n'y a pas de compte partagé entre deux personnes. On peut associer à une communauté ou à un membre plusieurs comptes à la fois.
11. Pour faciliter l'échange de services et promouvoir l'interaction sociale, on considèrera qu'un service peut être proposé, ou demandé. Les utilisateurs ne sont pas dépendants de l'offre, mais explicitent également la demande. De même, la palette d'offres peut inspirer les utilisateurs quant aux compétences qu'ils estiment posséder. 
12. Au niveau de l'implémentation, un service avec contre-partie peut être lié avec un service sans contre-partie, un service commercialisé, ou un autre service avec contre-partie dans la mesure où tous ces services sont identifiés. Un service identifié est un service qui a été enregistré dans notre BDD. Un service (contre partie) non identifié(e) s'exprimerait sur le mode descriptif, par exemple pourrait y figurer plusieurs propositions. L'utilisateur serait alors soumis à un choix : par exemple, jardinage ou cours de danse. On le considèrera comme un champ de texte personalisé. 
Concrètement, un utilisateur crée un service A, dit avec contre-partie. La contre-partie associée est alors soit identifiée, soit non identifiée. On dit d'une contre-partie qu'elle est identifiée si l'utilisateur renseigne dans la base de données le service qu'il propose en échange. La contre-partie est non identifiée quand l'utilisateur décrit le(s) type(s) de service au(x)quel(s) il aimerait répondre (généralement correlé(s) aux savoir-faire qu'il possède). 

## Contraintes
1. Deux savoir-faire ne peuvent pas avoir le même nom. On implémentera une vérification suffisament solide pour éviter les erreurs utilisateurs. On se munira d'un correcteur orthographique. 
2. Un lien ne peut pas se rapporter à lui-même. 




