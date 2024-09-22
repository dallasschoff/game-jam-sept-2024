extends AnimatedSprite2D

var lit = false
@export var start_frame : float = 0.0
@export var burn_radius : float = 40.0
@export var glow_speed : float = 2.0

func _ready():
	add_to_group("Burnables")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if lit:
		play("burning")

func _on_area_2d_area_entered(area):
	if area.get_parent() is Ripple:
		lit = true
		start_frame = Engine.get_process_frames()

func _on_burn_animation_finished():
	queue_free()
