extends "res://Scripts/branches.gd"

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
