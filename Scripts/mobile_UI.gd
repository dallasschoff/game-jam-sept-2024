extends Control

#D-Pad
@onready var upButton = $"D-Pad/UpButton"
@onready var downButton = $"D-Pad/DownButton"
@onready var leftButton = $"D-Pad/LeftButton"
@onready var rightButton = $"D-Pad/RightButton"

#Buttons
@onready var aButton = $"A + B/AButton"
@onready var bButton = $"A + B/BButton"



func _on_up_button_pressed() -> void:
	print("up button pressed")
	pass # Replace with function body.


func _on_a_button_pressed() -> void:
	print("a button pressed")
	pass # Replace with function body.
