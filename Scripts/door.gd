extends AnimatedSprite2D

@onready var totem = $"../Totem"
@onready var collision = $StaticBody2D/CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	totem.connect("totemActivate", _open)

func _open():
	await get_tree().create_timer(1.8).timeout
	$DoorOpenSound.play()
	play("open")
	await get_tree().create_timer(1).timeout
	collision.set_deferred("disabled", true)
