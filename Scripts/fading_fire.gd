extends AnimatedSprite2D
class_name FadingFire

@export var start_frame : float = 0.0
@export var glow_speed : float = 4.0
var lit = true
var burn_radius = 40.0
var min_burn_radius = -10.0

func _ready():
	add_to_group("Burnables")
	play("default")
	var scaleTween = get_tree().create_tween()
	scaleTween.tween_property(self, "scale", Vector2(0.1,0.1), 1)
	
func _process(delta):
	if burn_radius > min_burn_radius:
		burn_radius -= 0.3
		return
	queue_free()
