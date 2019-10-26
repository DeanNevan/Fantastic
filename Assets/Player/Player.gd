extends "res://Scripts/CreatureTemplate.gd"

var is_controlling = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_control_move(delta)
	_update_animation()

func _control_move(delta):
	if state == STATE_LOSE_CONTROL:
		return
	
	is_controlling = false
	velocity = Vector2()
	
	if Input.is_action_pressed("control_up"):
		velocity.y = -1
		is_controlling = true
	if Input.is_action_pressed("control_down"):
		velocity.y = 1
		is_controlling = true
	if Input.is_action_pressed("control_right"):
		velocity.x = 1
		is_controlling = true
	if Input.is_action_pressed("control_left"):
		velocity.x = -1
		is_controlling = true
	
	if !is_controlling:
		velocity = Vector2()
	else:
		change_state(STATE_MOVE)
	
	if velocity.length() == 0:
		change_state(STATE_IDLE)
		pass
	self.linear_velocity = velocity.normalized() * speed

func _update_animation():
	match state:
		STATE_IDLE:
			ani.animation = "idle"
		STATE_MOVE:
			if velocity.y < 0:
				ani.animation = "up"
			else:
				ani.animation = "down"
			if velocity.x > 0:
				ani.animation = "right"
			else:
				ani.animation = "left"
		STATE_LOSE_CONTROL:
			ani.animation = "lose_control"
		STATE_ATTACK:
			ani.animation = "attack"
		STATE_LAUNCH:
			ani.animation = "launch"