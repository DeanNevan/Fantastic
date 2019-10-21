extends Node

var is_choosed = false

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
