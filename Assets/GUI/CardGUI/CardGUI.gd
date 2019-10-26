extends Node

var follow_camera_length = 60

onready var player = get_parent().get_node("Player")
onready var camera = get_parent().get_node("Camera2D")

func _ready():
	
	var hey = preload("res://Assets/Card/Attack/GreatFireBall/CardGreatFireBall.tscn")
	
	for i in 12:
		var r = hey.instance()
		$Hand.add_child(r)
		r.change_state(r.STATE_CHOOSED)
		r.change_state(r.STATE_IDLE)

func _process(delta):
	var GUI_offset = camera.global_position - camera.get_camera_screen_center()
	var GUI_zoom = get_parent().get_node("Camera2D").zoom
	self.global_position = camera.get_camera_screen_center() + - GUI_offset / 3
	self.scale = GUI_zoom