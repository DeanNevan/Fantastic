extends "res://Scripts/CreatureTemplate.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _control_move():
	if body_state == STATE_LOSE_CONTROL:
		return
	change_state(STATE_MOVE)
	if Input.is_action_pressed("control_up"):
		linear_velocity.y = -1
	if Input.is_action_pressed("control_down"):
		linear_velocity.y = 1
	if Input.is_action_pressed("control_right"):
		linear_velocity.x = 1
	if Input.is_action_pressed("control_left"):
		linear_velocity.x = -1
	if linear_velocity.length() == 0:
		change_state(STATE_IDLE)

func _update_animation():
	match body_state:
		STATE_IDLE:
			ani.animation = "idle"
		STATE_MOVE:
			if linear_velocity.y < 0:
				ani.animation = "up"
			else:
				ani.animation = "down"
			if linear_velocity.x > 0:
				ani.animation = "right"
			else:
				ani.animation = "left"
		STATE_LOSE_CONTROL:
			ani.animation = "lose_control"
		STATE_ATTACK:
			ani.animation = "attack"
		STATE_LAUNCH:
			ani.animation = "launch"