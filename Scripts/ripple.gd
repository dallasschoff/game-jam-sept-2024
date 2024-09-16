extends Node2D

@export var end_radius = 30.0
@export var ripple_modulo = 12
var radius: float = 1.0

func _process(delta):
	if (radius == end_radius):
		queue_free()
	if (Engine.get_process_frames() % ripple_modulo == 0):
		print("draw")
		radius += 1
		queue_redraw()

func _draw():
	draw_circle(position, radius, Color(1,0.557,0.502), false, 0.1)
