extends Node2D
class_name Ripple

@export var end_radiusInner = 15.0
@export var end_radiusMiddle = 24.0
@export var end_radiusOuter = 30.0
# To find correct number: ratio of modulo and speed should be ratio or 12 / 5 (modulo / pulseSpeed)
@export var rippleSpeedModulo = 12
var radiusInner: float = 1.0
var radiusMiddle: float = 1.0
var radiusOuter: float = 1.0
@onready var collision = $Area2D/CollisionShape2D

func _process(delta):
	if (radiusOuter == end_radiusOuter):
		queue_free()
	if (Engine.get_process_frames() % rippleSpeedModulo == 0):
		radiusInner += 1
		radiusMiddle += 1
		radiusOuter += 1
		queue_redraw()
		if (collision.shape.radius != end_radiusOuter):
			collision.scale.x += 0.1
			collision.scale.y += 0.1

func _draw():
	# Inner radius (totem lighting)
	if radiusMiddle <= end_radiusMiddle:
		draw_circle(position, min(radiusInner-0.5,end_radiusInner), Color(0.773,0.227,0.616), false, 0.6)
	else:
		draw_circle(position, radiusInner-0.5-10, Color(0.773,0.227,0.616), false, 0.2)
	# Middle radius (thick lighting)
	if radiusMiddle <= end_radiusMiddle:
		draw_circle(position, radiusInner, Color(1,0.557,0.502), false, 1)
	# Outer radius (torch lighting / visibility)
	draw_circle(position, radiusOuter, Color(1,0.557,0.502), false, 0.1)
