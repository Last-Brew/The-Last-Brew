extends Node2D

var peer: ENetMultiplayerPeer
var type: String

@export var jack_scene: PackedScene
@export var jackson_scene: PackedScene
@export var zach_scene: PackedScene
@export var craig_scene: PackedScene

func _on_host_pressed():
	type = "jackson"
	peer = ENetMultiplayerPeer.new()
	peer.create_server(135)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_on_peer_connected)
	print("Host created, waiting for connections...")

func _on_jack_pressed():
	type = "jack"
	peer = ENetMultiplayerPeer.new()
	peer.create_client("localhost", 135)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_on_peer_connected)
	print("Jack client created, connecting to server...")

func _on_jackson_pressed():
	type = "jackson"
	peer = ENetMultiplayerPeer.new()
	peer.create_client("localhost", 135)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_on_peer_connected)
	print("Jackson client created, connecting to server...")

func _on_zach_pressed():
	type = "zach"
	peer = ENetMultiplayerPeer.new()
	peer.create_client("localhost", 135)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_on_peer_connected)
	print("Zach client created, connecting to server...")

func _on_craig_pressed():
	type = "craig"
	peer = ENetMultiplayerPeer.new()
	peer.create_client("localhost", 135)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_on_peer_connected)
	print("Craig client created, connecting to server...")

func _on_peer_connected(id):
	if type == "jack":
		_add_player(id, "jack")
	elif type == "jackson":
		_add_player(id, "jackson")
	elif type == "zach":
		_add_player(id, "zach")
	elif type == "craig":
		_add_player(id, "craig")
	else:
		print("Unknown type: ", type)

func _add_player(id, player_type):
	var player_scene: PackedScene

	if player_type == "jack":
		player_scene = jack_scene
	elif player_type == "jackson":
		player_scene = jackson_scene
	elif player_type == "zach":
		player_scene = zach_scene
	elif player_type == "craig":
		player_scene = craig_scene

	if player_scene:
		var player = player_scene.instantiate()
		player.name = str(id)
		call_deferred("add_child", player)
		print("Player added successfully.")
	else:
		print("No scene found for player type: ", player_type)
