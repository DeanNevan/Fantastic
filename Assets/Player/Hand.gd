extends Node2D

onready var player = get_parent()

var choosed_card_number = 1#选中的卡牌的编号

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_choose_card()
	#print(get_viewport().get_size())
	for i in get_child_count():
		if i == choosed_card_number - 1:
			get_child(i).is_choosed = true
		else:
			get_child(i).is_choosed = false
		get_child(i).global_position = Vector2(200 + 130 * i, get_viewport().get_size_override().y - 110)

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

