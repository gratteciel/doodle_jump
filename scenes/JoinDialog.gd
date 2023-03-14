extends WindowDialog

onready var connect_container: VBoxContainer = get_node("ConnectVBoxContainer")
onready var error_label: Label = get_node("ConnectVBoxContainer/error_label")
onready var spin_box : SpinBox = get_node("ConnectVBoxContainer/SpinBox")
onready var connect_button: Button = get_node("ConnectVBoxContainer/connect_button")

onready var wait_container = get_node("WaitScrollContainer")
onready var room_label = get_node("WaitScrollContainer/VBoxContainer/Label")

func _on_connect_button_pressed():
	connect_button.disabled = true
	Client.connect_to_server(spin_box.value)

func connected_ok():
	connect_container.hide()
	connect_button.disabled = false
	wait_container.show()
