extends Node

@export var speed : float = 200.0
var velocity : Vector2
@export var player_id : int = 1

@export var input_up : String = "ui_up"
@export var input_down : String = "ui_down"
@export var input_left : String = "ui_left"
@export var input_right : String = "ui_right"
var position : Vector2

func _ready():
	if get_tree().multiplayer.is_server():
		set_multiplayer_authority(get_tree().multiplayer.get_unique_id())
	else:
		pass

func _process(delta: float) -> void:
	velocity = Vector2()
	
	if Input.is_action_pressed(input_up):
		velocity.y -= 1
	if Input.is_action_pressed(input_down):
		velocity.y += 1
	if Input.is_action_pressed(input_left):
		velocity.x -= 1
	if Input.is_action_pressed(input_right):
		velocity.x += 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		position += velocity * delta
		rpc("update_position", position)

@rpc("any_peer")
func update_position(new_position: Vector2) -> void:
	position = new_position
