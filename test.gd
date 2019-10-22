extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _draw():
	draw_circle($Camera2D.get_camera_screen_center(), 5, Color.red)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update()
	$Camera2D.global_position = get_node("Player").global_position
