extends Node2D

var levelOne: PackedScene = load("res://Scenes/Level.tscn")
var main_menu: PackedScene = load("res://Scenes/MainMenu.tscn")
var current_level
var levels = { "1": levelOne, "2": main_menu }

func _ready():
	#var x = (DisplayServer.screen_get_size().x * 0.625) / 2
	#var y = DisplayServer.screen_get_size().y / 2
	DisplayServer.window_set_size(Vector2i(160 * 5, 144 * 5))
	main_menu.connect("start_game", start_game)

func start_game():
	var level: PackedScene = levels["1"]
	level.connect("level_over", change_level)
	get_tree().change_scene_to_packed(level)
	#var levelNode = level.instantiate()
	#add_child(levelNode)
	#current_level = levelNode
	#main_menu.queue_free()

func change_level(level_number: String):
	var level: PackedScene = levels[level_number]
	get_tree().change_scene_to_packed(level)
