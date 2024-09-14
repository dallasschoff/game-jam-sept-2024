extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	var x = (DisplayServer.screen_get_size().x * 0.625) / 2
	var y = DisplayServer.screen_get_size().y / 2
	DisplayServer.window_set_size(Vector2i(x, y))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
