extends Control

@onready var music = $OST

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		playMusic3()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func playMusic3():
	await get_tree().create_timer(1).timeout
	music.volume_db = -20
	music.play()
	var fadeIn2 = get_tree().create_tween()
	fadeIn2.tween_property(music,"volume_db",0,1.5)
