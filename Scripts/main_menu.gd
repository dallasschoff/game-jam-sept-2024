extends Control

signal start_game
var levelOne: PackedScene = load("res://Scenes/Level.tscn")

@onready var start_button = $MarginContainer/VBoxContainer/VBoxContainer/Start

func _ready():
	DisplayServer.window_set_size(Vector2i(160 * 5, 144 * 5))
	start_button.grab_focus()

func _on_start_pressed():
	get_tree().change_scene_to_packed(levelOne)

func _on_quit_pressed():
	get_tree().quit()
