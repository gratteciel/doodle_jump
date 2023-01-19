extends Node2D

onready  var player = $player
onready var camera = $Camera2D
onready var score_label = $Camera2D/score
onready var camera_initial_position = $Camera2D.position.y

onready var plateform_container = $plateform_container
onready var initial_plateform_y_position = $plateform_container/plateform.position.y

var score = 0
var last_plateform_is_cloud = false

export (Array, PackedScene) var  scene_plateform

func level_generator(amount):
	for i in amount :
		var new_type = randi() % 3
		initial_plateform_y_position -= rand_range(36,54)
		var new_plateform
		
		if new_type == 0 :
			new_plateform = scene_plateform[0].instance() as StaticBody2D
		elif new_type == 1 :
			new_plateform = scene_plateform[1].instance() as StaticBody2D
		elif new_type == 2 :
			if last_plateform_is_cloud == false :
				new_plateform = scene_plateform[2].instance() as StaticBody2D
				new_plateform.connect("delete_cloud",self,"delete_cloud")
				last_plateform_is_cloud = true
			else :
				new_plateform = scene_plateform[0].instance() as StaticBody2D
				last_plateform_is_cloud = false
		
		if new_plateform != null :
			new_plateform.position = Vector2(rand_range(20,160),initial_plateform_y_position)
			plateform_container.call_deferred("add_child",new_plateform)

func _ready() :
	randomize()
	level_generator(4000)

func _physics_process(delta):
	if player.position.y < camera.position.y :
		camera.position.y = player.position.y
	score_update()	

func delete_cloud(plateform) :
	plateform.queue_free()
	level_generator(1)

func score_update():
	score = int(camera_initial_position - camera.position.y)
	score_label.text = str(score)

func _on_plateform_eraser_body_entered(body):
	if body.is_in_group("player") :
		if score > Global.highscore :
			Global.highscore = score
		get_tree().change_scene("res://scenes/title_menu.tscn")
	elif body.is_in_group("plateform") :
		body.queue_free()
		level_generator(1)
