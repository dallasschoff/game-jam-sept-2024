extends AnimatedSprite2D

@onready var level2 = $".."
@onready var collision = $StaticBody2D/CollisionShape2D
@onready var music = $"../OST"

var circleList

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	circleList = get_children()
	for circle in circleList:
		if circle is Sprite2D:
			circle.add_to_group("DoorCircles")
		
	level2.connect("allTotemsLit", _open)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _open():
	await get_tree().create_timer(1.8).timeout
	music.stop()
	await get_tree().create_timer(0.4).timeout
	$DoorOpenSound.play()
	play("open2")
	await get_tree().create_timer(1).timeout
	collision.set_deferred("disabled", true)
	await get_tree().create_timer(1).timeout
	music.play()
