extends Control

onready var label_meilleur_score = $TextureRect/conteneur_principal/meilleur_score
onready var boutton_commencer = $TextureRect/conteneur_principal/choix_menu/Commencer/commencer

func _ready():
	boutton_commencer.grab_focus()
	label_meilleur_score.text = "Meilleur Score:\n" + str(int(Global.meilleur_score))

func _on_commencer_pressed():
	get_tree().change_scene("res://scenes/Monde.tscn")


func _on_quitter_pressed():
	get_tree().quit()
