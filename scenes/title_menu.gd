extends Control

onready var highscore_label = $main_container/highscore
onready var solo_vutton = $main_container/menu/solo

func _ready() :
	highscore_label.text = "Highscore\n" + str(Global.highscore)


func _on_exit_pressed():
	get_tree().quit()


func _on_solo_pressed():
	get_tree().change_scene("res://scenes/doodle_jump.tscn")


func _on_multiplayer_pressed():
	get_tree().change_scene("res://scenes/Multi_menu.tscn")
