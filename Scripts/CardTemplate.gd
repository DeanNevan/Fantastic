extends Node

signal prepare
signal not_prepare
signal start



var state = STATE_IDLE
enum{
	STATE_IDLE
	STATE_CHOOSED
	STATE_DRAGGED
}

var is_choosed = false

var is_dragged = false

var is_prepared = false

var is_dragging = false
var drag_start_position_1 = Vector2()
var drag_start_position_2 = Vector2()
var drag_speed = 150
var drag_offset = Vector2()

var in_hand_position = Vector2()

onready var tween_1 = Tween.new()
onready var tween_2 = Tween.new()
onready var tween_3 = Tween.new()
var _is_tween_1 = false
var _is_tween_2 = false

onready var pair_scene
onready var tween_4 = Tween.new()#用作卡片的淡出

onready var player = get_parent().get_parent().get_parent().get_node("Player")

func _ready():
	add_child(tween_1)
	add_child(tween_2)
	add_child(tween_3)
	add_child(tween_4)
	
	connect("pair_scene_init_ok", self, "_on_pair_scene_init_ok")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("key_space") and state == STATE_CHOOSED:
		change_state(STATE_DRAGGED)
		prepare(false)
	if Input.is_action_just_released("key_space") and state == STATE_DRAGGED:
		change_state(STATE_IDLE)
		prepare(true)
	
	match state:
		STATE_IDLE:
			pass
		STATE_CHOOSED:
			pass
		STATE_DRAGGED:
			pass

func change_state(target_state):
	if state == STATE_IDLE and target_state == STATE_CHOOSED:
		SE_choosed(false)
	if state == STATE_CHOOSED and target_state == STATE_IDLE:
		SE_choosed(true)
	if state == STATE_CHOOSED and target_state == STATE_DRAGGED:
		SE_fade_out(self, 0.5)
	if state == STATE_DRAGGED and target_state == STATE_IDLE:
		SE_fade_in()
		SE_choosed(true)
	#print("state is ", state)
	#print("change state to ", target_state)
	state = target_state

func prepare(is_reversed = false):#显示配对的场景动画or reversed
	if is_reversed:
		emit_signal("not_prepare")
	else:
		emit_signal("prepare")

func start():
	emit_signal("start")

func _on_pair_scene_init_ok():
	player.get_parent().call_deferred("add_child", pair_scene)#在下添加子节点
	pair_scene.change_state(pair_scene.STATE_IDLE)
	pair_scene.pair_card = self
	pair_scene.visible = false
	pair_scene.pair_card_init_ok()


func SE_drag():
	if is_dragged and !is_dragging:
		is_dragging = true
		drag_start_position_1 = self.global_position
	if !is_dragged and is_dragging:
		drag_start_position_1 = self.global_position
		is_dragging = false
	
	if is_dragged:
		#print(((get_parent().get_global_mouse_position() - self.global_position).length() / (get_parent().get_global_mouse_position() - drag_start_position_1).length()))
		drag_offset += clamp(((get_parent().get_global_mouse_position() - self.global_position).length() / (get_parent().get_global_mouse_position() - drag_start_position_1).length()) * drag_speed, 0, drag_speed) * (get_parent().get_global_mouse_position() - self.global_position).normalized()
	else:
		if (in_hand_position - drag_start_position_1).length() != 0:
			drag_offset -= clamp(((self.global_position - in_hand_position).length() / (in_hand_position - drag_start_position_1).length()) * drag_speed, 0, drag_speed) * - (in_hand_position - self.global_position).normalized()

func SE_fade_out(target = self, degree = 1, speed = 0.3):
	tween_4.interpolate_property(self, "modulate", self.modulate, Color(1, 1, 1, 1 - degree), speed, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween_4.start()

func SE_fade_in(target = self, degree = 1, speed = 0.3):
	tween_4.interpolate_property(self, "modulate", self.modulate, Color(1, 1, 1, degree), speed, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween_4.start()

func SE_choosed(is_reversed = false):
	if !is_reversed:
		_is_tween_2 = false
		if !_is_tween_1:
			_is_tween_1 = true
			tween_1.interpolate_property(self, "scale", self.scale, Vector2(1.6, 1.6), 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN)
			tween_1.start()
			tween_2.interpolate_property($InformationRect, "modulate", $InformationRect.modulate, Color(1, 1, 1, 0.8), 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN)
			tween_2.start()
			tween_3.interpolate_property($Info, "modulate", $Info.modulate, Color(1, 1, 1, 1), 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN)
			tween_3.start()
	else:
		_is_tween_1 = false
		if !_is_tween_2:
			_is_tween_2 = true
			tween_1.interpolate_property(self, "scale", self.scale, Vector2(1, 1), 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN)
			tween_1.start()
			tween_2.interpolate_property($InformationRect, "modulate", $InformationRect.modulate, Color(1, 1, 1, 0), 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN)
			tween_2.start()
			tween_3.interpolate_property($Info, "modulate", $Info.modulate, Color(1, 1, 1, 0), 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN)
			tween_3.start()