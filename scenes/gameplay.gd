extends Node2D

onready var joueur = $Adel
onready var camera = $Camera2D
onready var gestionnaire_pltf = $gestionnaire_pltf #il va génerer des plateformes au fur et à mesure dans des position relativement aléatoires
onready var ordonnee_premiere_plateforme = $gestionnaire_pltf/plateforme.position.y #variable modifiant la position en ordonnée des plateformes standard
onready var compteur_score = $Camera2D/Score #valeur du score affiché à l'écran
onready var cadrage_initial = $Camera2D.position.y #position initiale de la caméra: utilisée pour compter le score

export (Array, PackedScene) var scene_platforme #on charge la scène2D avec la plateforme que l'on avait précedemment

var score = 0
var blocage_nuage = false
var ratio = false

func generateurDeNiveau(amount): #le nombre de plateformes générées est illimité
	for i in amount:
		var type_plateforme = randi() % 4 #retourne un entier entre 0 et 2
		ordonnee_premiere_plateforme -= rand_range(54,60) #on va vers les ordonnees négatives donc il faut constamment créer des plateformes en abaissant leur ordonnées dans un certain range pour qu'on puisse quand même l'atteindre
		var nouvelle_plateforme #on ajoute une plateforme dans la scene depuis laquelle on avait créé la première plateforme afin quer le jeu puisse l'utiliser
		
		if type_plateforme == 0: #en fonction du retour de la variable, on chrqge un type de plateforme différent
			nouvelle_plateforme = scene_platforme[0].instance() as StaticBody2D
			
		elif type_plateforme == 1:
			nouvelle_plateforme = scene_platforme[1].instance() as StaticBody2D
			
		elif type_plateforme >= 2:
			if blocage_nuage == false and score > 1000: #empêche dávoir une succession de blocs qui disparaissent pour le softlock
				nouvelle_plateforme = scene_platforme[type_plateforme].instance() as StaticBody2D
				nouvelle_plateforme.connect("disparition",self,"disparition") #activation de la fonction "disparition" (1) avec en paramètre la plateforme elle-même (2) en cas de signal "disparition"(3)
				blocage_nuage = true
			else:
				nouvelle_plateforme = scene_platforme[0].instance() as StaticBody2D
				blocage_nuage = false
		
		if nouvelle_plateforme != null:
			nouvelle_plateforme.position = Vector2(rand_range(20, 160),ordonnee_premiere_plateforme) #on lui donne une position aléatoire dans une certaine fourchette d'abscisse et ordonnée
			gestionnaire_pltf.call_deferred("add_child",nouvelle_plateforme) #ajouter une plateforme dans le  gestionnaire (call_deferred active la fonction "add_child(nouvelle_plateforme)" si le thread n'est pas occupé (améliore la fluidité au coût dún possible non chargement des plateformes)
	
func _ready():
	randomize() #on active le randomizer avant de commencer pour ne pas avoir le même placement que précédemment
	generateurDeNiveau(20) #on répète le processus de création et de placement de plateforme continuellement
	joueur.connect("mortConfirmee",self,"mortConfirmee")

func _physics_process(delta):
	if joueur.position.y < camera.position.y: #si le joueur dépasse le cadre de la caméra vers le haut...
		camera.position.y = joueur.position.y #...la caméra le rattrape
	marquerScore()

func _on_poubelle_pltf_body_entered(body): #lorsqu'on entre dans la zone de destruction
	
	if body.is_in_group("joueur"): #si le joueur tombe dans le vide on recommence
		if score > Global.meilleur_score:
			Global.meilleur_score = score
			get_tree().change_scene("res://scenes/Highscore.tscn")
		elif ratio == true:
			get_tree().change_scene("res://scenes/Gameover.tscn")
		else:	
			get_tree().change_scene("res://scenes/Menu.tscn")
		
	elif body.is_in_group("plateforme") or body.is_in_group("ennemi"):
		body.queue_free() #tout objet s'y trouvant est éffacé
		generateurDeNiveau(1) #on recrée alors une nouvelle plateforme

func disparition(plateforme): #lorsqu'on entre en contact avec la plateforme nuage
	plateforme.queue_free() #elle disparait
	generateurDeNiveau(1) #une autre plateforme est générée plus loin
	
func marquerScore(): #le score est la différence entre la position initiale de la caméra et sa position actuelle
	score = int(cadrage_initial - camera.position.y)
	compteur_score.text = str(score) #on le note à chaque frame

func mortConfirmee(joueur):
	ratio = true
