extends AnimatedSprite2D

@onready var music = $"../OST"
@onready var totem = $"../Totem"
@onready var collision = $StaticBody2D/CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	totem.connect("totemActivate", _open)

func _open():
	await get_tree().create_timer(1.8).timeout
	music.stream_paused = true
	await get_tree().create_timer(0.4).timeout
	$DoorOpenSound.play()
	play("open")
	await get_tree().create_timer(1).timeout
	collision.set_deferred("disabled", true)
	await get_tree().create_timer(1).timeout
	music.stream_paused = false
