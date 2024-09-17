extends Node2D
class_name Pulse

@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	add_to_group("Pulses")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	animated_sprite.play("pulse_ground_fire")
