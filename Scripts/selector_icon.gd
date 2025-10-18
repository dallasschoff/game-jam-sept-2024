extends AnimatedSprite2D
var isInstance = false

func _process(delta: float) -> void:
	if $"../PulseQueueUiArrows" != null:
		if visible == true: 
			$"../PulseQueueUiArrows".visible = true
		else: $"../PulseQueueUiArrows".visible = false

func _on_animation_finished() -> void:
	if animation == "appear":
		play("default")
	if animation == "disappear" and isInstance == true:
		queue_free()
	else: visible = false
	if animation == "delete" and isInstance == true:
		queue_free()
	else: visible = false
