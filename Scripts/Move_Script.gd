extends CharacterBody2D

@export var speed : float = 200.0
@export var player_id : int

@export var input_up : String = "ui_up"
@export var input_down : String = "ui_down"
@export var input_left : String = "ui_left"
@export var input_right : String = "ui_right"

func _ready():
	if get_tree().get_multiplayer().is_server():
		player_id = get_tree().get_multiplayer().get_unique_id()
		set_multiplayer_authority(player_id)
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
		rpc("update_position", global_position) # Use global_position here

@rpc("any_peer")
func update_position(new_position: Vector2) -> void:
	global_position = new_position # Update global_position directly
