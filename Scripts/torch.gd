extends AnimatedSprite2D
class_name Torch

@export var lit = false
@onready var torch_light = $PointLight2D

func _ready():
	add_to_group("Torches")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if lit:
		play("burning")

#When another body (player or pulse) enters a torch's area2d, the torch should be lit
func _on_area_2d_area_entered(area):
	lit = true
	torch_light.enabled = true
