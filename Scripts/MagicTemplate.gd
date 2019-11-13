extends Area2D

signal pair_card_init_ok

#状态机
var state = STATE_IDLE
enum{
	STATE_IDLE
	STATE_PREPARE
	STATE_START
	STATE_LAUNCH
	STATE_END
}

#var is_dragging = false
var drag_start_position_1 = Vector2()
#var drag_start_position_2 = Vector2()
var drag_speed = 90
#var drag_offset = Vector2()

onready var tween_fade = Tween.new()
var is_tween_fade = false

onready var pair_card

func _ready():
	add_child(tween_fade)
	pair_card.connect("prepare", self, "_prepare")
	pair_card.connect("start", self, "_start")
	pair_card.connect("not_prepare", self, "_not_prepare")

func _process(delta):
	match state:
		STATE_IDLE:
			change_particles_emit(false)
			_drag(true)
		STATE_PREPARE:
			change_particles_emit(true)
			visible = true
			_drag(false)
		STATE_START:
			pass
		STATE_LAUNCH:
			pass
		STATE_END:
			pass

#当与此魔法配对的卡片初始化完成
func pair_card_init_ok():
	emit_signal("pair_card_init_ok")

#拽动方法
func _drag(is_reversed = false):
	if !is_reversed:
		self.global_position += ((get_global_mouse_position() - global_position).length() / (get_global_mouse_position() - drag_start_position_1).length()) * drag_speed * (get_global_mouse_position() - global_position).normalized()
	else:
		self.global_position += ((pair_card.global_position - global_position).length() / (pair_card.global_position - drag_start_position_1).length()) * drag_speed * (pair_card.global_position - global_position).normalized()

#改变所有粒子节点的发射状态
func change_particles_emit(is_emit = true):
	for i in get_node("Particles").get_child_count():
		get_node("Particles").get_child(i).emitting = is_emit

#状态机
func change_state(target_state):
	if state == STATE_IDLE and target_state == STATE_PREPARE:
		SE_fade_in($AnimatedSprite, 0.5)
		global_position = pair_card.global_position
		drag_start_position_1 = pair_card.global_position
	if state == STATE_PREPARE and target_state == STATE_IDLE:
		drag_start_position_1 = global_position
		SE_fade_out($AnimatedSprite)
	state = target_state

func _prepare():
	change_state(STATE_PREPARE)
	$AnimatedSprite.animation = "prepare"

func _not_prepare():
	change_state(STATE_IDLE)

func _start():
	change_state(STATE_START)
	$AnimatedSprite.animation = "start"

func _launch():
	change_state(STATE_LAUNCH)
	$AnimatedSprite.animation = "launch"

func _end():
	change_state(STATE_END)
	$AnimatedSprite.animation = "end"

#淡出特效
func SE_fade_out(target = self, degree = 1, speed = 0.3):
	
	tween_fade.interpolate_property(target, "modulate", target.modulate, Color(1, 1, 1, 1 - degree), speed, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween_fade.start()

#淡入特效
func SE_fade_in(target = self, degree = 1, speed = 0.3):
	
	tween_fade.interpolate_property(target, "modulate", target.modulate, Color(1, 1, 1, degree), speed, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween_fade.start()