extends KinematicBody2D

var pesanteur = 10 #on définit les constantes
var vitesse = Vector2.ZERO #on crée un vecteur 2D avec une abscisse et ordonnée nulles
var hauteurDeSaut = 400
var accelerationHorizontale = 200

func Deplacement(delta): #delta représente une frame sur l'ordinateur
	
	vitesse.y += pesanteur #on augmente la vitesse à chaque instant par la constante de pesanteur
	
	var collision = move_and_collide(vitesse * delta) #le personnage bouge dans la direction souhaitée (ici il tombe) jusqu'à un contact avec un objet de collision
	
	if collision: #move_and_collide retourne un bool en cas de contact
		vitesse.y= -hauteurDeSaut #crée le rebond
		
	#Animation de chute
	if vitesse.y > 0:
		$AnimatedSprite.play("fall");
	else:
		$AnimatedSprite.play("default");

	var directionHorizontale=0 #on a un momentum horizontal nul au départ
	
		
	if Input.is_action_pressed("ui_right"): #en cas d'input flèche de droite
		directionHorizontale += 1
		$AnimatedSprite.flip_h = true #on inverse en effet miroir le sprite du personnage pour si;uler qu'il se tourne
		
	elif Input.is_action_pressed("ui_left"): 
		directionHorizontale -= 1
		$AnimatedSprite.flip_h = false
		
	if directionHorizontale!=0:
		#vitesse.x = directionHorizontale * accelerationHorizontale
		vitesse.x = lerp(vitesse.x, directionHorizontale * accelerationHorizontale, 0.8) #simule une déceleration progressive après arrêt d'appui de la touche
		#fonctionnement: lerp renvoie une moyenne d'une fraction deux premières valeurs, ;oyenne définie par la troisième
	else:
		#vitesse.x=0
		vitesse.x = lerp(vitesse.x, 0, 0.2)

	#la portion de code suivante permet au joueur de passer d'un côté à l'autre de l'écran
	if position.x < 0: #si on revient avant l'abscisse de base
		position.x = get_viewport_rect().size.x
		
	elif position.x > get_viewport_rect().size.x: #si on dépasse la taille de l'écran (le cqdre en bleu sur le Node2D)
		position.x = 0
		
#Le code ci-dessous gère la physique du personnage

func _physics_process(delta): #_physics_process est un type de fonction pré-existant
	Deplacement(delta)
