extends "res://Scripts/CardTemplate.gd"

signal pair_scene_init_ok

# Called when the node enters the scene tree for the first time.
func _ready():
	pair_scene = preload("res://Assets/Magic/Attack/GreatFireBall/MagicGreatFireBall.tscn").instance()
	emit_signal("pair_scene_init_ok")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
