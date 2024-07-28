extends Node

var peer = ENetMultiplayerPeer.new()

func _ready():
	# Creates a server on port 69420 with a total number of 4 clients
	peer.create_server(69420, 4)
	get_tree().get_multiplayer().network_peer = peer
