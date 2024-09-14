extends Control

signal start_game

@onready var start_button = $MarginContainer/VBoxContainer/VBoxContainer/Start

func _ready():
	start_button.grab_focus()

func _on_start_pressed():
	start_game.emit()

func _on_quit_pressed():
	get_tree().quit()
