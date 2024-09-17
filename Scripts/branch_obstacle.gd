extends AnimatedSprite2D

var burning = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if burning:
		play("burning")

func _on_area_2d_area_entered(area):
	if area.get_parent() is Ripple:
		burning = true

func _on_burn_animation_finished():
	queue_free()
