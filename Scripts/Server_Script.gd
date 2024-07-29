extends Node

var peer = ENetMultiplayerPeer.new()
var Jack_scene : PackedScene
var Jackson_scene : PackedScene
var Zach_scene : PackedScene
var Craig_scene : PackedScene
var players = {}

func _ready():
	# Create a server on port 69420 with a maximum of 4 clients
	peer.create_server(42069, 4)
	get_tree().multiplayer.network_peer = peer
	
	# Load the character scene
	Jack_scene = preload("res://Character_TCSN/jack_node.tscn")
	Jackson_scene = preload("res://Character_TCSN/jackson_node.tscn")
	Zach_scene = preload("res://Character_TCSN/zach_node.tscn")
	Craig_scene = preload("res://Character_TCSN/craig_node.tscn")

func _on_peer_connected(id):
	# When a new peer connects, create a unique character for them
	if players.size() < 4:
		var character : CharacterBody2D
		if id == 0:
			character = Jack_scene.instantiate() as CharacterBody2D
		if id == 1:
			character = Jackson_scene.instantiate() as CharacterBody2D
		if id == 2:
			character = Zach_scene.instantiate() as CharacterBody2D
		if id == 3:
			character = Craig_scene.instantiate() as CharacterBody2D
		add_child(character)
		players[id] = character
		character.set_multiplayer_authority(id)
		print("Player connected: ", id)
	else:
		print("Too many players connected")

func _on_peer_disconnected(id):
	# Remove the character when the player disconnects
	if id in players:
		var character = players[id]
		character.queue_free()
		players.erase(id)
		print("Player disconnected: ", id)
