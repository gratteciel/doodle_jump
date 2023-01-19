extends KinematicBody2D

var gravity = 10
var jump_force = 400
var speed = 100
var velocity = Vector2.ZERO

func movement(delta) :
	velocity.y += gravity
	var collision =  move_and_collide(velocity*delta)
	if collision :
		velocity.y = -jump_force*collision.collider.jump_power
		if collision.collider.has_method("response") :
			collision.collider.response()
	
	if velocity.y > 0 :
		$AnimatedSprite.play("fall")
	else :
		$AnimatedSprite.play("default")
	
	var dir = 0
	
	if Input.is_action_pressed("ui_right"):
		dir+=1
		$AnimatedSprite.flip_h = true
	elif Input.is_action_pressed("ui_left"):
		dir-=1
		$AnimatedSprite.flip_h = false
	
	if dir!=0 :
		velocity.x = lerp(velocity.x, dir*speed,0.8)
	else :
		velocity.x = lerp(velocity.x, 0,0.2)
	
	if position.x < 0 :
		position.x = get_viewport_rect().size.x
	elif position.x > get_viewport_rect().size.x :
		position.x = 0

func _physics_process(delta):
	movement(delta)
	

