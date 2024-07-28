extends Node

var peer = ENetMultiplayerPeer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	# creates a client on add 127.0.0.1 that connects to port 69420
	peer.create_client("127.0.0.1", 69420)
	get_tree().get_multiplayer().network_peer = peer
