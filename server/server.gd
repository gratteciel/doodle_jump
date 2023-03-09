extends Control

var network = NetworkedMultiplayerENet.new()
var port = 3234
var max_players = 2
var players = {}
var ready_players = 0

func _ready():
	start_server()

func start_server():
	network.create_server(port,max_players)
	get_tree().set_network_peer(network)
	network.connect("peer_connected",self,"_player_connected")
	network.connect("peer_disconnected",self,"_player_disconnected")
	print("Server started")

func _player_conncted(player_id):
	print("Player : "+str(player_id)+" Connected")

func _player_disconncted(player_id):
	print("Player : "+str(player_id)+" Disonnected")

remote func send_player_info(id, player_data):
	players[id] = player_data
	rset("players", players)
	rpc("update_waiting_room")
