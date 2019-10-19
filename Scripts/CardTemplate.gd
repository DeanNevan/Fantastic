extends Node

var is_choosed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_choosed:
		self.scale = Vector2(1.3, 1.3)
		$InformationRect.visible = true
	else:
		self.scale = Vector2(1, 1)
		$InformationRect.visible = false
