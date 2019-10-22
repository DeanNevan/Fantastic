extends Node

var is_choosed = false

var is_dragged = false

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

func _ready():
	add_child(tween_1)
	add_child(tween_2)
	add_child(tween_3)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	SE_fade()
	SE_drag()

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

func SE_fade():
	if is_choosed:
		_is_tween_2 = false
		if !_is_tween_1:
			_is_tween_1 = true
			tween_1.interpolate_property(self, "scale", Vector2(1, 1), Vector2(1.6, 1.6), 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN)
			tween_1.start()
			tween_2.interpolate_property($InformationRect, "modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 0.8), 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN)
			tween_2.start()
			tween_3.interpolate_property($Info, "modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 1), 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN)
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