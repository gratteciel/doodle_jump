extends StaticBody2D

export var jump_power = 4

func response() :
	$AnimatedSprite.play("default")


func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.stop()
	$AnimatedSprite.frame = 0
