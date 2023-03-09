extends Control

onready var player_name = $ColorRect/VBoxContainer/GridContainer/nametextbox
onready var selected_ip = $iptextbox
onready var waiting_room = $WaitingRoom
onready var selected_port = $porttextbox
onready var ready_button = $WaitingRoom/ColorRect/VBoxContainer/ready_button

func _ready():
	player_name.text = Save.save_data["Player_name"]
	selected_ip.text = Server.DEFAULT_IP
	selected_port.text = str(Server.DEFAULT_PORT)

func _on_join_button_pressed():
	Server.selected_ip = selected_ip.text
	Server.selected_port = int(selected_port.text)
	Server._connect_to_server()
	show_waiting_room()

func _on_NameTextBox_text_changed(new_text):
	Save.save_data["Player_name"] = player_name.text
	Save.save_game()

func show_waiting_room():
	waiting_room.popup_centered()

func _on_ready_button_pressed():
	ready_button.disabled = true
