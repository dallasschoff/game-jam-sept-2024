extends AnimatedSprite2D
class_name Branches

var lit = false
@export var start_frame : float = 0.0
@export var max_burn_radius : float = 40.0
@export var glow_speed : float = 2.0
var fade_light = false
var burn_radius = -10.0
@onready var collision = $StaticBody2D/CollisionShape2D

func _ready():
	add_to_group("Burnables")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if lit and not fade_light and burn_radius < max_burn_radius:
		play("burning")
		burn_radius += 0.2
	if fade_light and burn_radius > 0:
		burn_radius -= 0.25
	elif fade_light and burn_radius < 0:
		queue_free()

func _on_area_2d_area_entered(area):
	if area.get_parent() is Ripple:
		lit = true
		start_frame = Engine.get_process_frames()

func _on_burn_animation_finished():
	fade_light = true
	collision.set_deferred("disabled", true)
	
