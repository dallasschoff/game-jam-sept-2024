extends Node2D
class_name Ripple

@export var end_radius = 30.0
# To find correct number: ratio of modulo and speed should be ratio or 12 / 5 (modulo / pulseSpeed)
@export var rippleSpeedModulo = 12
var radius: float = 1.0
@onready var collision = $Area2D/CollisionShape2D

func _process(delta):
	if (radius == end_radius):
		queue_free()
	if (Engine.get_process_frames() % rippleSpeedModulo == 0):
		radius += 1
		queue_redraw()
		if (collision.shape.radius != end_radius):
			collision.scale.x += 0.1
			collision.scale.y += 0.1

func _draw():
	draw_circle(position, radius, Color(1,0.557,0.502), false, 0.1)
