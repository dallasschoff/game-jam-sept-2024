extends Node2D

@onready var animated_sprite = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	animated_sprite.play("pulse_ground_fire")
