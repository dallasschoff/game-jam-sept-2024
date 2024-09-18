extends AnimatedSprite2D
class_name Torch

var lit = false
@export var start_frame : float = 0.0
@export var burn_radius : float = 60.0
@export var glow_speed : float = 4.0

func _ready():
	add_to_group("Burnables")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if lit:
		play("burning")

#When another body (player or pulse) enters a torch's area2d, the torch should be lit
func _on_area_2d_area_entered(area):
	if lit == false:
		lit = true
		start_frame = Engine.get_process_frames()
