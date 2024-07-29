extends Node

var peer = ENetMultiplayerPeer.new()
var Jack_scene : PackedScene
var Jackson_scene : PackedScene
var Zach_scene : PackedScene
var Craig_scene : PackedScene
var my_character : CharacterBody2D

func _ready():
	# Connect to the server
	peer.create_client("127.0.0.1", 42069)
	get_tree().multiplayer.network_peer = peer
	
	# Load the character scene
	Jack_scene = preload("res://Character_TCSN/jack_node.tscn")
	Jackson_scene = preload("res://Character_TCSN/jackson_node.tscn")
	Zach_scene = preload("res://Character_TCSN/zach_node.tscn")
	Craig_scene = preload("res://Character_TCSN/craig_node.tscn")

func _on_network_peer_connected(id):
	if id == get_tree().multiplayer.get_unique_id():
		# Instantiate the character for this client
		var character : CharacterBody2D
		if id == 0:
			character = Jack_scene.instantiate() as CharacterBody2D
		if id == 1:
			character = Jackson_scene.instantiate() as CharacterBody2D
		if id == 2:
			character = Zach_scene.instantiate() as CharacterBody2D
		if id == 3:
			character = Craig_scene.instantiate() as CharacterBody2D
		get_tree().root.add_child(my_character)
		my_character.set_multiplayer_authority(id)
		print("My character created: ", id)
