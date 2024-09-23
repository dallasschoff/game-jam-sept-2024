extends AnimatedSprite2D
class_name Totem

signal totemActivate

var lit = false
@export var start_frame : float = 0.0
@export var max_burn_radius : float = 30.0
@export var glow_speed : float = 4.0
var firstActivated : bool = false
var burn_radius = -10.0
var fade_light = false

func _ready():
	play("default")
	add_to_group("Burnables")
	add_to_group("DoorTotems")
	
func _process(delta):
	if lit and not fade_light and burn_radius < max_burn_radius:
		burn_radius += 0.25
	elif not lit and fade_light and burn_radius > -10.0:
		burn_radius -= 0.1

#When a pulse enters a totem's area2d, the totem should be lit
func _on_area_2d_area_entered(area):
	if lit == false:
		lit = true
		fade_light = false
		start_frame = Engine.get_process_frames()
		play("start_burning")
		if not firstActivated:
			totemActivate.emit()
			firstActivated = true

#When an area2d exits (despawns) the totem's area2d, the totem should extinguish
func _on_area_2d_area_exited(area):
	if lit == true:
		await get_tree().create_timer(1).timeout
		lit = false
		fade_light = true
		play("reverse_start_burning")

func _on_animation_finished():
	if lit:
		play("burning")
