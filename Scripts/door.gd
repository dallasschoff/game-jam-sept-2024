extends AnimatedSprite2D

@onready var totem = $"../Totem"
@onready var collision = $StaticBody2D/CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	totem.connect("totemActivate", _open)

func _open():
	collision.set_deferred("disabled", true)
	play("open")
