extends Node2D

onready var player = get_parent().get_parent().get_node("Player")

var choosed_card_number = 1#选中的卡牌的编号

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_choose_card()
	
	for i in get_child_count():
		if i == choosed_card_number - 1:
			if get_child(i).state == get_child(i).STATE_IDLE:
				get_child(i).change_state(get_child(i).STATE_CHOOSED)
			get_child(i).is_choosed = true
		else:
			if get_child(i).state == get_child(i).STATE_CHOOSED:
				get_child(i).change_state(get_child(i).STATE_IDLE)
			get_child(i).is_choosed = false
		
		var card_camera_offset = Vector2(220 + 130 * i - get_viewport().get_size_override().x / 2, get_viewport().get_size_override().y / 2 - 110)
		
		get_child(i).in_hand_position = get_parent().global_position + card_camera_offset
		
		get_child(i).position = card_camera_offset + get_child(i).drag_offset
	
	"""if Input.is_action_pressed("key_space"):#空格按下，将被选中的卡片设置为“dragged”即拖拽状态
		for i in get_child_count():
			if get_child(i).is_choosed:
				get_child(i).is_dragged = true
				get_child(i).state = get_child(i).STATE_DRAGGED
			else:
				get_child(i).state = get_child(i).STATE_IDLE
				get_child(i).is_dragged = false
	else:
		for i in get_child_count():
			get_child(i).state = get_child(i).STATE_IDLE
			get_child(i).is_dragged = false"""

func _choose_card():
	if get_child_count() == 0:
		choosed_card_number = 0
		return
	if Input.is_action_just_released("wheel_up"):
		choosed_card_number -= 1
		if choosed_card_number < 1:
			choosed_card_number = get_child_count()
		
	if Input.is_action_just_released("wheel_down"):
		choosed_card_number += 1
		if choosed_card_number > get_child_count():
			choosed_card_number = 1

