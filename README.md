# Préambule

Slides du cours disponibles [ici](http://slides.com/women_on_rails/week-5)

Ce tutoriel a pour objectif de comprendre comment manipuler des objets dans le contrôleur et passer les données de ces objets à des vues (création et édition), dans le cadre du cycle 1 des ateliers Women On Rails.

# Étape 1 : Rappels

## Commandes principales

Vous pouvez retrouver les commandes utiles pour le terminal, git et la console Ruby On Rails [ici](https://women-on-rails.github.io/guide/main_commands).

## MVC

Le rappel sur le patron de conception [Modèle - Vue - Controleur] peut être trouvé [ici](https://openclassrooms.com/courses/apprendre-asp-net-mvc/le-pattern-mvc)

## Actions HTTP

Ruby On Rails permet d'utiliser au mieux le [protocole HTTP](https://openclassrooms.com/courses/les-requetes-http), sur lequel repose la navigation Web. Il y a 4 types de requêtes principales en HTTP :
- GET (afficher une page),
- POST (créer une nouvelle ressource),
- PUT (pour modifier entièrement la ressource, ou PATCH pour la modifier partiellement),
- DELETE (supprimer une ressource).

Suite à chaque requête, le serveur envoie une réponse.

De plus, chaque contrôleur Rails possède 7 actions de base, chaque action correspondant à un type de requête HTTP :
- SHOW : affiche une ressource en particulier (action GET)
- INDEX : affiche la liste de toutess les ressources d'un même type (action GET)
- NEW : affiche le formulaire pour créer une nouvelle ressource (action GET)
- CREATE : une fois le précédent formulaire complété, crée la ressource (action POST)
- EDIT : affiche le formulaire d’édition d'une ressource (action GET)
- UPDATE : met à jour une ressource spécifiée (action PUT)
- DESTROY : supprime une ressource spécifique (action DELETE)

# Étape 2 : Lire l'exercice et se lancer

## Application au projet Curiosités

Ouvrez votre projet avec Cloud9, ou l'éditeur que vous utilisez si vous avez une installation native.

Si vous utilisez SublimeText, vous pouvez faire ```subl .``` dans la console pour ouvrir directement votre projet. (subl c'est SublimeText, l'espace c'est parce que la commande est finie, et le point c'est pour dire "ouvre dans Sublime Text tout le dossier dans lequel je suis, en un coup").

## Ajout d'un formulaire de création des curiosités

Nous avons créé des moyens d'afficher ou de détruire une curiosité spécifique lors du tutoriel [week-5](https://github.com/women-on-rails/week-5). Nous allons maintenant faire en sorte de pouvoir créer une nouvelle curiosité.

Si l'on reprend les actions de base d'un contrôleur Rails, voici celles qui nous intéressent:
- NEW : affiche le formulaire pour créer une nouvelle ressource (action GET)
- CREATE : une fois le précédent formulaire complété, crée la ressource (action POST)

Nous allons ajouter pas à pas ces deux nouvelles méthodes à notre contrôleur ``` CuriositiesController ```.

### Ajout de la méthode ```new``` dans le contrôleur ```CuriositiesController```

Ouvrez le fichier ``` app/controllers/curiosities_controller.rb```. Pour le moment, il contient les méthodes ``` show ``` et ``` destroy ```. Ajoutons-y la méthode ``` new ``` qui permet d'instancier une nouvelle curiosité que nous utiliserons dans le formulaire de création.

![Methode NEW](/images/readme/controller_method_new.png)

Maintenant, occupons-nous de la vue associée à cette méthode ```new```.

### Ajout du formulaire de création

Créez le fichier ``` app/views/curiosities/new.html.erb ```.
Ce fichier va contenir un formulaire permettant de créer une curiosité composée d'un nom (``` name ```), d'une description (``` description ```), d'un lien vers une image (``` image_url ```) et d'une description relative à l'image (``` image_text ```).

Voici comment serait un formulaire créé simplement avec du HTML et du CSS version Bootstrap :
``` HTML
<h1> Création d'une nouvelle curiosité </h1>

<form action="/curiosities" method="post">
  <div class="form-group">
    <label for="curiosityName">Name</label>
    <input type="text" class="form-control" name="curiosity[name]">
  </div>
  <div class="form-group">
    <label for="curiosityDescription">Description</label>
    <input type="text" class="form-control" name="curiosity[description]">
  </div>
  <div class="form-group">
    <label for="curiosityImageUrl">Image Url</label>
    <input type="text" class="form-control" name="curiosity[image_url]">
  </div>
  <div class="form-group">
    <label for="curiosityImageText">Image text</label>
    <input type="text" class="form-control" name="curiosity[image_text]">
  </div>
  <input type="submit" value="Créer la curiosité" class="btn btn-default" />
</form>
```

Nous utilisons Ruby On Rails pour créer notre application. Pour générer notre formulaire, nous allons donc pouvoir utiliser des outils en plus de HTML et CSS. Cela va nous permettre d'éviter des erreurs, d'ajouter de la logique de sécurité automatiquement, et de réutiliser ce formulaire par la suite pour l'édition des curiosités.

Voici le code de notre formulaire, avec du HTML et des outils fournis par Ruby On Rails :

``` Ruby
<h1> Création d'une nouvelle curiosité </h1>

<%= form_for :curiosity, url: curiosities_path do |c| %>
  <div class="form-group">
	<%= c.label :name %>
    <%= c.text_field :name, class: 'form-control' %>
  </div>
  <div class="form-group">
	<%= c.label :description %>
    <%= c.text_field :description, class: 'form-control' %>
  </div>
  <div class="form-group">
	<%= c.label :image_url %>
    <%= c.text_field :image_url, class: 'form-control' %>
  </div>
  <div class="form-group">
	<%= c.label :image_text %>
    <%= c.text_field :image_text, class: 'form-control' %>
  </div>

  <%= c.submit 'Créer la curiosité', class: "btn btn-default" %>
<% end %>
````

#### Explication du formulaire

Avec Ruby On Rails, vous pouvez créer des formulaires de la manière suivante:
``` Ruby
<%= form_for :curiosity, url: curiosities_path do |c| %>
````

Cette ligne permet d'ouvrir un formulaire.
Le formulaire se finit toujours par <% end %> car c'est un bloc.

Ici, ``` curiosities_path ``` se réfère à l'action à effectuer avec les données du formulaire quand l'utilisateur clique sur le bouton `Créer la curiosité`. Notez que le formulaire fait des requêtes HTTP ``` POST ``` ce qui permet au contrôleur de savoir quelle méthode utiliser.

La section suivante permet d'ajouter un champ texte à votre formulaire, avec son label:
``` Ruby
  <div class="form-group">
	<%= c.label :name %>
    <%= c.text_field :name, class: 'form-control' %>
  </div>
````

La section suivante permet de créer le bouton pour soumettre le formulaire:
``` Ruby
  <%= c.submit 'Créer la curiosité', class: "btn btn-default" %>
````

### Ajout des nouvelles routes

Nous avons créé la méthode ``` new ``` dans le contrôleur ``` CuriositiesController``` et la vue associée. Nous devons donc maintenant permettre à un utilisateur d'aller sur cette vue. Pour cela, ouvrez le fichier ``` config/routes.rb ``` et ajoutez-y deux nouvelles routes:

![Routes](/images/readme/routes_new_create.png)

La ligne ``` get 'curiosities/new', to: 'curiosities#new', as: 'new_curiosity' ``` permet de rediriger l'utilisateur vers la page de création d'une curiosité.

La ligne ``` post 'curiosities', to: 'curiosities#create', as: 'curiosities' ``` dit au contrôleur que l'on veut utiliser les données du formulaire dans une méthode ``` create```.

> Astuce : Notez que la position des routes est importante.
> Si vous obtenez une erreur, vérifiez l'ordre de vos routes.

### Ajout de la méthode ``` create ``` dans le contrôleur ``` CuriositiesController ```

À ce stade, nous avons un formulaire mais ne savons pas comment utiliser les données qu'il contient.

Ouvrez de nouveau le fichier ``` app/controllers/curiosities_controller.rb```. Ajoutez-y la méthode ``` create ``` qui va permettre de sauvegarder en base de données une nouvelle curiosité dont nous avons récupéré les informations grâce au formulaire de création.

![Methode CREATE](/images/readme/controller_method_create.png)

### Ajouter le lien pour créer une curiosité dans l'index

Il faut maintenant afficher à l'utilisateur qu'il peut créer une nouvelle curiosité. Pour cela, dans l'index, nous allons créer un lien vers la vue new contenant le formulaire de création.

> Rappel :
> Un lien dynamique se construit de cette façon en Ruby On Rails :

> ```Ruby <%= link_to 'Nom du lien qui sera affiché dans la vue', chemin_vers_le_contrôleur %>````

Trouvons le chemin (``` path ```) qui indiquera la route vers la méthode du contrôleur dans le fichier ``` config/routes.rb ```.

> Rappel : vous pouvez entrer ``` rake routes ``` dans votre terminal pour trouver tous les chemins déjà définis.

![Rake routes](/images/readme/rake_routes.png)

Vous retrouvez bien le verbe HTTP ``` GET ``` (cf Verb), l'url ``` /curiosities/new ``` (cf URI Pattern), la méthode du Contrôleur ``` curiosities#new ``` (cf Controller#Action). Et tout devant, un préfixe ``` new_curiosity ``` qui vous donne en fait le chemin à rajouter dans votre vue : ``` new_curiosity_path ```. Ici, pas besoin de donner l'identifiant d'une curiosité en paramètre puisqu'elle n'existe pas encore.

> Rappel : ``` new_curiosity_path ``` est une méthode générée par Ruby On Rails directement, en fonction de ce que vous avez défini dans le fichier ``` routes.rb ```.

Rajoutez le lien dans votre vue ``` app/views/home/index.html.erb ``` :

![Lien pour créer une curiosité ](/images/readme/view_code_link_formular.png)

Et maintenant, testez votre formulaire !

![Lien vers formulaire](/images/readme/view_link_formular.png)

![Formulaire](/images/readme/formular.png)

![Vue apres creation](/images/readme/view_show.png)

# Étape 3 : Pour aller plus loin

## Ajout du formulaire d'édition

Reprenez les étapes de construction du formulaire de création en vous aidant du [guide Ruby On Rails](http://guides.rubyonrails.org/getting_started.html#updating-articles) pour créer un formulaire d'édition des curiosités.

Les méthodes à ajouter au contrôleur sont:
- EDIT : affiche le formulaire d’édition d'une ressource (action GET)
- UPDATE : met à jour une ressource spécifiée (action PUT)

La vue à créer se nomme ``` app/views/curiosities/edit.html.erb ```.

## Utilisation d'un partial

Vous avez créé un formulaire de création et un formulaire d'édition. Vous pouvez constater qu'ils se ressemblent très fortement. Pour éviter de dupliquer votre code, essayez d'utiliser un [partial](http://french.railstutorial.org/chapters/filling-in-the-layout#sec:partials), contenant le formulaire, que vous inclurez dans les fichiers ``` app/views/curiosities/new.html.erb ``` et ``` app/views/curiosities/edit.html.erb ```.

## Ajout d'une image

Pour rendre notre page plus sympa, nous aimerions avoir une image à la place du texte `Nouvelle Curiosité` du lien de création. Amusez-vous à remplacer ce texte par une icône en utilisant les icônes bootstrap, dont vous pouvez trouver la documentation [ici](http://getbootstrap.com/components/) !

# Étape 4 : Enregistrer les modifications sur le répertoire distant

[Enregistrer vos modifications et les envoyer sur votre répertoire Github](https://women-on-rails.github.io/guide/push_project)

# Liens Utiles :
- La documentation de Ruby : http://ruby-doc.org/core-2.3.1/
- La documentation de Ruby On Rails : http://api.rubyonrails.org/
- Active Record : https://fr.wikipedia.org/wiki/Active_record (concept en français) ou http://guides.rubyonrails.org/active_record_basics.html (introduction de Rails, en anglais)
- Les routes dans Ruby On Rails : http://guides.rubyonrails.org/routing.html
- Informations sur les partials : http://french.railstutorial.org/chapters/filling-in-the-layout#sec:partials
