extends Node2D

@export var LevelScene: PackedScene
@onready var main_menu = $CanvasLayer/MainMenu

func _ready():
	#var x = (DisplayServer.screen_get_size().x * 0.625) / 2
	#var y = DisplayServer.screen_get_size().y / 2
	DisplayServer.window_set_size(Vector2i(160 * 5, 144 * 5))
	main_menu.connect("start_game", start_game)

func start_game():
	var level = LevelScene.instantiate()
	add_child(level)
	main_menu.queue_free()
