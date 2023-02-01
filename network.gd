extends Node

const DEFAULT_PORT = 4242
const MAX_cLIENTS = 2

var server = null
var client = null

var ip_address = ""

func _ready() -> void:
	#adresse ip windows
	ip_address = IP.get_local_addresses()[3]
	
	for ip in IP.get_local_addresses():
		if ip.begins_with("192.168."):
			ip_address = ip
			
	get_tree().connect("connected_to_server", self, "_connected_to_server")
	get_tree().connect("server_disconnected", self, "_server_disconnected")
	
func create_server() -> void:
	server = NetworkedMultiplayerENet.new()
	server.create_server(DEFAULT_PORT, MAX_cLIENTS)
	get_tree().set_network_peer(server)
	
func join_server() -> void:
	client = NetworkedMultiplayerENet.new()
	client.create_client(ip_address, DEFAULT_PORT)
	get_tree().set_network_peer(server)
	get_tree().set_network_peer(client)
	
func _connected_to_server() -> void:
	print("connecte au serveur")
	
func _server_disconnected() -> void:
	print("deconnecte du serveur")
