extends Node

var speed = 200
var velocity = Vector2()
var player_id = 1

var input_up = "ui_up"
var input_down = "ui_down"
var input_left = "ui_left"
var input_right = "ui_right"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = Vector2()
	
	if Input.is_action_just_pressed(input_up):
		velocity.y -= 1
	if Input.is_action_just_pressed(input_down):
		velocity.y += 1
	if Input.is_action_just_pressed(input_left):
		velocity.x -= 1
	if Input.is_action_just_pressed(input_right):
		velocity.x += 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	

# Multi player syncing to be added
func _sync_position():
	pass
