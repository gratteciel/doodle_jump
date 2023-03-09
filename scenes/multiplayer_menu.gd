extends Control


func _on_menu_button_pressed():
	get_tree().change_scene("res://scenes/title_menu.tscn")

func _on_join_button_pressed():
	get_tree().change_scene("res://scenes/Join.tscn")

func _on_host_button_pressed():
	get_tree().change_scene("res://scenes/Server.tscn")
