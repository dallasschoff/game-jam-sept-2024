extends AnimatedSprite2D

@onready var player: Player = $"../Player"

func _ready():
	add_to_group("Collectibles")

func _on_area_2d_area_entered(area):
	player.collectibleCounter += 1
	queue_free()
