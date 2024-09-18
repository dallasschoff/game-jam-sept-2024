extends AnimatedSprite2D
class_name Totem

signal totemActivate

var lit = false
@export var start_frame : float = 0.0
@export var burn_radius : float = 30.0
@export var glow_speed : float = 4.0

func _ready():
	play("default")
	add_to_group("Burnables")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#When a pulse enters a totem's area2d, the totem should be lit
func _on_area_2d_area_entered(area):
	if lit == false:
		lit = true
		start_frame = Engine.get_process_frames()
		play("start_burning")
		totemActivate.emit()

#When an area2d exits (despawns) the totem's area2d, the totem should extinguish
func _on_area_2d_area_exited(area):
	if lit == true:
		lit = false
		play("reverse_start_burning")

func _on_animation_finished():
	if lit:
		play("burning")
