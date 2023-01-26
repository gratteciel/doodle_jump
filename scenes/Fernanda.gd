extends StaticBody2D

export var coefficient_rebond = 1

onready var tween = $Tween

var direction = Vector2(1,0)
var acceleration = 100
var vitesse = Vector2.ZERO
var ecran

signal disparition(plateforme)

func _input(event):
	adaptation()

func adaptation():
	var position_depart = position
	var position_arrivee = position_depart + Vector2(0, 10)
	tween.interpolate_property(self, "position", position_depart, position_arrivee, 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN, 0)
	tween.start()
	#emit_signal("disparition",self) #signal de disparition pour que le programme principal le détecte
	
func interaction():
	emit_signal("disparition",self) #signal de disparition pour que le programme principal le détecte
	
func _ready():
	ecran = get_viewport_rect().size
	set_physics_process(false)

func _physics_process(delta):
	mouvement(delta)
	
func mouvement(delta):
	vitesse = acceleration * direction
	position += vitesse * delta
	if position.x >= ecran.x:
		direction *= -1
		$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
	elif position.x <= 0:
		direction *= -1
		$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h


func _on_hitbox_body_entered(body):
	if body.is_in_group("joueur"):
		body.mort()


func _on_VisibilityEnabler2D_screen_entered():
	set_physics_process(true)


#func _on_Tween_tween_all_completed():
#	emit_signal("disparition",self)
