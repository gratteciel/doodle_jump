extends Control

onready var create_dialog: AcceptDialog = get_node("VBoxContainer/CreateDialog")
onready var create_dialog_label: Label = get_node("VBoxContainer/CreateDialog/ScrollContainer/VBoxContainer/loading_label")
onready var create_dialog_player_list: VBoxContainer = get_node("VBoxContainer/CreateDialog/ScrollContainer/VBoxContainer/PlayerList")
onready var join_dialog: WindowDialog = get_node("JoinDialog")
onready var join_room_label: Label = join_dialog.get_node("WaitScrollContainer/VBoxContainer/Label")
onready var join_player_list: VBoxContainer = join_dialog.get_node("WaitScrollContainer/VBoxContainer/PlayerList")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func update_room(room_id : int) -> void :
	if Client.is_creator :
		create_dialog_label.text = "Room id: " + str(room_id)
	else:
		join_room_label.text = "Room id : "+str(room_id)
		join_dialog.connected_ok()

func _on_return_pressed():
	get_tree().change_scene("res://scenes/title_menu.tscn")


func _on_create_pressed():
	Client.create_rooom()
	create_dialog.popup_centered()


func _on_popup_hide()->void:
	if get_tree().network_peer != null:
		Client.stop()


func _on_join_pressed():
	join_dialog.popup_centered()

func add_player_to_ui(name: String) -> void:
	if Client.is_creator:
		create_dialog_player_list.add_player(name)
	else:
		join_player_list.add_player(name)
		
		
func remove_player(index: int) -> void:
	if Client.is_creator:
		create_dialog_player_list.remove_player(index)
	else:
		join_player_list.remove_player(index)


func remove_all_players() -> void:
	if Client.is_creator:
		create_dialog_player_list.remove_all()
		create_dialog.hide()
	else:
		join_player_list.remove_all()
		join_dialog.hide()
