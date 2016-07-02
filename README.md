# Étape 1 : Récuperer le projet week-6

Ouvrez une console et entrez dans votre répertoire de travail (aidez vous des commandes ````cd```` (Changement de Dossier) et ````ls```` (LiSte des fichiers)).
Créez un nouveau dossier de travail (````mkdir```` : MaKe DIRectory):
``` Console
mkdir week-6
````

Entrez dans ce dossier:
``` Console
cd week-6
````

Initialisez GIT pour votre projet:
``` Console
git init
````
Vous allez maintenant lier votre répertoire ````week-6```` situé sur votre ordinateur avec un répertoire distant week-6 situé sur votre compte github. Le lien sera appelé ````origin````.
Pour cela, créez un nouveau répertoire appelé ````week-6```` sur Github et copiez l'url de ce répertoire.
Puis, faites la commande suivante, en remplaçant (votre compte) dans cette adresse par votre compte :
``` Console
git remote add origin git@github.com:(votre compte)/week-6.git
````
Cela vous permet de synchroniser votre compte github avec les modifications que vous ferez sur le projet ````week-6```` sur votre ordinateur.

À cette étape, si vous faites ````ls```` dans votre console, le dossier ````week-6```` doit être vide.
Et si vous faites ````ls -a```` le dossier ````week-6```` ne contient que les fichiers de configuration de git, dans le dossier caché ````.git````.

Maintenant, vous allez lier votre répertoire ````week-6```` situé sur votre ordinateur avec le répertoire distant ````week-6```` situé sur le compte des Women On Rails. Le lien sera appelé ````upstream````.
Pour cela, faites la commande suivante :
``` Console
git remote add upstream git@github.com:women-on-rails/week-6.git
````
Cela va vous permettre de récupérer facilement le code existant nécessaire pour la suite de l'exercice. 

Pour récupérer ce code, faites la commande suivante :
``` Console
git pull upstream master
````

Cela remplit le dossier ````week-6```` sur votre ordinateur avec tout ce que contient le projet ````week-6```` sur le compte Github des Women On Rails.
En faisant un ````ls````, vous pourrez voir la liste des fichiers copiés. 

Vous voila prête pour l'exercice !

# Étape 2 : Lire l'exercice et se lancer

[Retrouvez les slides du cours](http://slides.com/soniaprevost/womenonrails-week5#/)

### Lancer le serveur sur lequel va tourner l'application

En premier lieu, vérifiez que votre application a tous les Gems (plug-ins, bibliothèques... bref des briques de code) qu'elle utilise à disposition : vous pouvez les installer automatiquement en faisant la commande ````bundle install```` dans votre console, à l'intérieur du dossier de votre projet ````week-6````.

Si un problème survient au niveau de la version de ruby, vous devriez avoir besoin d'effectuer la commande ````rbenv install 2.3.1```` dans la console pour installer la version de ruby dont l'application a besoin. 
(Si rbenv ne connait pas cette version, utilisez la commande ````brew update && brew upgrade ruby-build```` avant)
Puis, installez bundler pour cette version avec la commande ````gem install bundle````. Et enfin, faites un ````bundle update````pour mettre a jour vos plug-ins. 

Pour lancer un serveur Ruby On Rails, vous devez faire la commande ````rails server```` (ou ````rails s````) toujours dans votre console. 
Et voila, votre serveur est lancé !

### Visualiser l'application sur le navigateur

Après avoir lancé votre serveur, vous pourrez ouvrir votre navigateur pour y coller l'URL suivante : [http://localhost:3000/](http://localhost:3000/)
Vous devriez visualiser le contenu de la vue que vous avez ouverte précédement. 
Apres avoir fait des modifications sur cette vue, vous n'aurez qu'à recharger la page du navigateur pour voir vos modifications apparaître. (rafraîchir: F5 ou ````CTRL + R```` sous windows, ````CMD + R```` sous mac)

### Manipuler des objets dans la console 

#### La base de données et ses migrations

Lorsque l'on crée une application, on écrit des algorithmes visant à manipuler des données.
On veut pouvoir en conserver certaines dans la durée, et c'est le rôle de ce que l'on appelle une "base de données".

Une base de données est un logiciel dans lequel on peut stocker des informations de manière structurée, en évitant au maximum les redondances, pour les réutiliser de diverses manières. 

Dans Rails, une "migration" est ce qui va permettre de faire évoluer la structure et le contenu de la base de données, au fil du développement d'un projet. Les migrations ne prennent pas en compte le type de base de données utilisé. Elles fonctionnent sur n'importe quelle base de données gérée par Ruby On Rails. 

En ouvrant le fichier ````/db/migrate/20160618174815_create_curiosities.rb```` (les chiffres peuvent changer en fonction de la date à laquelle vous l'avez faite) vous pouvez voir comment est composée une migration qui créée une table. 

```Ruby 
class CreateCuriosities < ActiveRecord::Migration
  def change
    create_table :curiosities do |t|
      t.string :name
      t.text :description
      t.text :image_url
      t.string :image_text

      t.timestamps null: false
    end
  end
end
````

Une migration est une classe de type ````ActiveRecord::Migration````. La migration ````CreateCuriosities```` contient une méthode ````change```` qui, lorsque l'on applique la migration, va créer la table ````curiosities```` dans la base de données (````create_table :curiosities````). 

Cette table ````curiosities```` a plusieurs colonnes (que l'on décrit dans le "block" ````do````):
- ````name```` : le nom d'une curiosité, qui est une petite chaine de caractères (````String````)
- ````description```` : la description de la curiosité, qui est une grande chaine de caractères (````Text````)
- ````image_url```` : l'url vers l'image de la curiosité, qui est une grande chaine de caractères (````Text````)
- ````image_text```` : légende accompagnant l'image de la curiosité, qui est une petite chaine de caractères (````String````)
- ````created_at```` : date de création d'une curiosité, qui est un objet ````DateTime```` (date + horaire)
- ````updated_at```` : date de derniere mise à jour d'une curiosité, qui est un objet ````DateTime```` (date + horaire)

On peut créer les deux dernières colonnes (````created_at```` et ````updated_at````) en un coup grâce à un raccourci : la ligne ````t.timestamps null: false````. Il est intéressant de noter que vous n'avez pas besoin de "penser" à ces deux champs : rien qu'avec leur nom, Ruby on Rails détecte que ce sont des champs pour garder les dates de création et modification (si vous aviez des champs de création / modification qui ne sont PAS nommés ainsi, il faudrait le faire soi-même).

Dans le cadre de l'exercice, notez que la migration CreateCuriosity a déjà été appliquée à la base de données.

Lorsque des migrations ont été effectuées sur la base de données de votre application, il est possible de retrouver sa structure complète dans le fichier ````/db/schema.rb````.

Ouvrez ce fichier. Vous pouvez constater que vous retrouvez la méthode de création de la table ````Curiosities````, avec tout ce qui la compose. 

> Astuce : 
> Une migration a un identifiant. Cela permet à votre application de savoir quelle est la dernière migration qui a été traitée, pour éviter de la rejouer. Cet identifiant de migration est visible dans le nom du fichier de la migration. 

Vous pouvez voir à quelle migration vous en êtes dans le fichier ````/db/schema.rb```` avec ````version: 20160618174815````.

#### ActiveRecord et les modèles

ActiveRecord est la partie de Ruby On Rails qui permet de manipuler les informations stockées en base de données avec des classes Ruby (qu'on appelle les modèles).

Cela permet de représenter les attributs d'une table de la base de données dans un modèle, pour avoir accès à chacune des lignes de cette table (comme une ligne dans Excel !) et pouvoir les manipuler. 

Ouvrez votre terminal puis ouvrez une console Ruby On Rails : ````rails console```` (ou ````rails c````)

Nous allons maintenant récupérer une curiosité stockée en base de données. Dans votre console, tappez ````curiosity = Curiosity.find(1)````

Cela va d'abord vous afficher la requête SQL faite grâce à Active Record pour récupérer la curiosité qui a l'identifiant `1` en base de données (ici ce sont des numéros croissants donc c'est la numéro 1 ou #1, mais ça n'est pas obligé) :

````
Curiosity Load (0.2ms)  SELECT  "curiosities".* FROM "curiosities" WHERE "curiosities"."id" = ? LIMIT 1  [["id", 1]]
````

À la suite de cette ligne, vous pouvez voir l'objet qui représente la curiosité #1 avec tous ses attributs : 

````
#<Curiosity:0x007f9f697791c8
 id: 1,
 name: "Joli mug",
 description: "Reçu au Japon, lors d'un congrès interlitières",
 image_url:
  "https://s-media-cache-ak0.pinimg.com/236x/4a/86/bf/4a86bfbf02b472e5b385762b8f267a91.jpg",
 image_text: "Un grand mug de lait pour bien commencer la journée",
 created_at: Sat, 18 Jun 2016 17:54:37 UTC +00:00,
 updated_at: Sat, 18 Jun 2016 17:54:37 UTC +00:00>
 ````

La ligne avec l'identifiant 1 de la table ````Curiosity```` de la base de données a été abstraite dans le modèle (ou classe) ````Curiosity```` de l'application, ce qui donne une instance de ce modèle. 

Nous allons maintenant quitter la console Rails : pour cela, tapez "exit" dans la console à partir du terminal. 

#### Ajouter de nouveaux attributs

Nous aimerions ranger chaque curiosité dans des catégories, une par curiosité. Par exemple :
- le joli mug sera de catégorie ````Vaisselle```` 
- la bobine de fil sera de catégorie ````Coffre à jouet````
- le super t-shirt sera de catégorie ````Penderie````
- le jeu de société Catopoly sera de catégorie ````Coffre à jouet````
- etc

Pour cela, il faut ajouter un nouvel attribut ````Category```` à la table ````Curiosity```` de la base de données. Pour demander à Ruby On Rails de créer notre nouvelle migration, il faut utiliser le générateur de migrations avec la commande suivante dans le terminal : 

````
rails generate migration add_category_to_curiosities category:string
````

Cette commande crée un nouveau fichier de migration dans le dossier ````db```` situé à la racine du dossier de l'application. Ouvrez ce fichier de migration avec votre éditeur de texte.

Le contenu devrait ressembler à cela :

```Ruby
class AddCategoryToCuriosities < ActiveRecord::Migration
  def change
    add_column :curiosities, :category, :string
  end
end
````

Il y a donc la classe ````AddCategoryToCuriosities````, qui "hérite" de ````ActiveRecord::Migration```` (elle sait faire tout ce que sa classe mère sait faire). Dans cette classe-là, on a la méthode ````change```` permettant de faire des modifications sur la base de données. 

Dans la méthode ````change````, il y a la ligne ````add_column :curiosities, :type, :string````. ````add_column```` veut dire que l'on demande à ajouter une colonne à une table qui s'appelle ````Curiosities```` (````:curiosities````) et que cette nouvelle colonne s'appelle ````category```` (````:category````) et est de type ````String````.

Le fichier de la migration a été créé, mais n'a pas encore été exécuté. D'ailleurs, si on regarde le fichier ````db/schema.rb````, le numéro de version n'est pas encore celui de cette mirgation : il est encore au numéro de celle d'avant (dans notre exemple ````20160618174815````).

Pour appliquer notre nouvelle migration, nous devons effectuer la commande suivante dans le terminal :
````rake db:migrate````

````rake```` est un outil permettant de lancer des "tâches". Il a une "famille" de tâches "db" pour gérer la base de données, et on souhaite qu'il exécute la tâche ````migrate````.

Cela devrait afficher quelque chose de similaire à : 
````
$ rake db:migrate
#== 20160626095924 AddCategoryToCuriosities: migrating #=========================
#-- add_column(:curiosities, :category, :string)
#   -> 0.0029s
#== 20160626095924 AddCategoryToCuriosities: migrated (0.0029s) ================
````
Grace à ce message, on sait que notre migration a été effectuée avec succès. Si on rouvre de nouveau le fichier ````db/schema.rb````, on peut voir que le numéro de version a été mis à jour et que notre nouvelle colonne est bien prise en compte : 
```Ruby 
  create_table "curiosities", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.text     "image_url"
    t.string   "image_text"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "category"
  end
````

Revenons dans une console Ruby On Rails pour voir ce qu'il en est de notre instance de classe ````Curiosity````. Tapez ````curiosity = Curiosity.find(1)````

Cela va de nouveau vous afficher la requête que ActiveRecord envoie à la base de données pour récupérer la curiosité #1 :

````
Curiosity Load (0.2ms)  SELECT  "curiosities".* FROM "curiosities" WHERE "curiosities"."id" = ? LIMIT 1  [["id", 1]]
````

Puis, vous pouvez voir l'objet qui représente la curiosité #1 avec tous ses attributs, dont l'attribut ````category````... qui est vide pour le moment : 

````
#<Curiosity:0x007ff36803a300
 id: 1,
 name: "Joli mug",
 description: "Reçu au Japon, lors d'un congrès interlitières",
 image_url:
  "https://s-media-cache-ak0.pinimg.com/236x/4a/86/bf/4a86bfbf02b472e5b385762b8f267a91.jpg",
 image_text: "Un grand mug de lait pour bien commencer la journée",
 created_at: Sat, 18 Jun 2016 17:54:37 UTC +00:00,
 updated_at: Sat, 18 Jun 2016 17:54:37 UTC +00:00>,
 category: nil>
 ````

#### Pour aller plus loin

Si vous souhaitez renseigner les catégories de toutes vos curiosités, il serait intéressant de rajouter une validation au niveau du modèle ````Curiosity```` pour que l'attribut ````category```` n'accepte que quelques valeurs. Cela permet d'être sûr de ce qu'il y a en base de données et d'éviter les doublons 'cachés'.

Par exemple, si on veut avoir une catégorie 'Penderie', pour simplifier la recherche sur cette catégorie, on ne veut pas pouvoir créer des curiosités avec la catégorie 'penderie' ou 'pendrie' ou encore 'PenDeRie'. Seule la 'Penderie' sera acceptée comme valeur de l'attribut ````category````.

Aidez vous de la page 'Validations' du guide Ruby On Rails (http://guides.rubyonrails.org/active_record_validations.html) et ajoutez une validation au niveau de l'attribut ````category```` du modèle ````Curiosity```` pour n'accepter que les valeurs suivantes : 
- Penderie
- Coffre à jouets
- Vaisselle
- Décorations
- Amis
- Bibliothèque

# Étape 3 : Enregistrer les modifications sur le dépôt distant

Lorsque vous avez fait des modifications dans votre projet ````week-6````, vous pouvez avoir besoin de les enregistrer pour ne pas les effacer malencontreusement. Pour cela, vous allez les ````commit```` (par abus de langage en français "commiter") : sauvegarder l'ensemble des modifications, pas pour votre éditeur de texte, mais pour git.

Pour voir les différences entre ce que vous avez en ce moment dans les fichiers et ce que git a compris "depuis la dernière sauvegarde", vous pouvez lancer la commande suivante :
``` Console
git status
````
Vous verrez ce qui n'est pas encore "dans git", en rouge.

Pour committer ces changements, vous devez d'abord les ajouter aux modifications à prendre en compte avec la commande :
``` Console
git add .
````

Si vous souhaitez ne prendre en compte que certaines modifications et pas d'autres, vous pouvez utiliser la commande :
``` Console
git add -p 
````
Cela vous permettra de visualier chaque modification et de l'ajouter (````y````) ou non (````n````). 

Quand vous aurez ajouté ce que vous voulez, vous pouvez à nouveau lancer la commande :
``` Console
git status
````
Vous verrez ce qui n'est pas dans votre commit en rouge, et ce qui sera ajouté dans le prochain commit en vert.

Pour "vraiment" enregistrer les modifications "en vert", il faut faire la commande :
``` Console
git commit 
````

Il est vraiment pratique de décrire le contenu de votre commit, pour vous ou pour les autres.
Vous pouvez y ajouter un message avec l'option ````-m```` suivie du message :
``` Console
git commit -m "ce commit sert à faire ceci"
````
Cela permet de savoir rapidement à quoi correspond le commit, au lieu de regarder sa composition. 

Pour envoyer votre commit vers votre repertoire distant (sur Github), vous devez ensuite utiliser la commande ````push````:
```Console
git push 
````

Allez voir sur github, vos modifications apparaîtront :)

# Pour aller plus loin :
- La documentation de Ruby : http://ruby-doc.org/core-2.3.1/
- La documentation de Ruby On Rails : http://api.rubyonrails.org/
- Active Record : https://fr.wikipedia.org/wiki/Active_record (concept en français) ou http://guides.rubyonrails.org/active_record_basics.html (introduction de Rails, en anglais)
- Comparaison entre Sqlite, MySql et Postgres (EN) : https://www.digitalocean.com/community/tutorials/sqlite-vs-mysql-vs-postgresql-a-comparison-of-relational-database-management-systems
- Les migrations (EN) : http://guides.rubyonrails.org/active_record_migrations.html
- Les validations (EN) : http://guides.rubyonrails.org/active_record_validations.html
