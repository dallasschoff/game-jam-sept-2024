extends Node2D

@export var end_radius = 30.0
# To find correct number: ratio of modulo and speed should be ratio or 12 / 5 (modulo / pulseSpeed)
@export var rippleSpeedModulo = 12
var radius: float = 1.0

func _process(delta):
	if (radius == end_radius):
		queue_free()
	if (Engine.get_process_frames() % rippleSpeedModulo == 0):
		print("draw")
		radius += 1
		queue_redraw()

func _draw():
	draw_circle(position, radius, Color(1,0.557,0.502), false, 0.1)
