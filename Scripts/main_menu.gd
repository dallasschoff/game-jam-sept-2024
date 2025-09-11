extends Control

signal start_game
var levelOne: PackedScene = load("res://Scenes/Level.tscn")
var mobileControls
@onready var subViewportContainer = $"../SubViewportContainer/SubViewport"

@onready var start_button = $MarginContainer/VBoxContainer2/Start

func _ready():
	#DisplayServer.window_set_size(Vector2i(160 * 5, 144 * 5))
	start_button.grab_focus()
	Global.mainMenu = self

func _on_start_pressed():
	var level_instance = levelOne.instantiate()
	if subViewportContainer != null:
		subViewportContainer.add_child(level_instance)
	queue_free()
	#get_tree().change_scene_to_packed(levelOne)

func _on_quit_pressed():
	get_tree().quit()

func _on_check_box_toggled(toggled_on: bool) -> void:
	if toggled_on:
		mobileControls = true
		get_window().size.y = 288
	if !toggled_on:
		mobileControls = false
		get_window().size.y = 144
