extends Node

var follow_camera_length = 60

onready var player = get_parent().get_node("Player")
onready var camera = get_parent().get_node("Camera2D")

func _ready():
	
	var hey = preload("res://Assets/Card/Attack/great_fire_ball/great_fire_ball.tscn")
	
	for i in 12:
		$Hand.add_child(hey.instance())

func _process(delta):
	var GUI_offset = camera.global_position - camera.get_camera_screen_center()
	self.global_position = camera.get_camera_screen_center() + - GUI_offset / 3