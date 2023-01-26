extends StaticBody2D

export var coefficient_rebond = 2

func interaction():
	$AnimatedSprite.play("default") #animation de rebond en cas de contact


func _on_AnimatedSprite_animation_finished(): #réinitialisation au cas initial après
	$AnimatedSprite.stop()
	$AnimatedSprite.frame = 0
