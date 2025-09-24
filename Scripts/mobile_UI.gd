extends Control

#D-Pad
@onready var dPadSprite = $"D-Pad"

@onready var upButton = $"D-Pad/UpButton"
@onready var downButton = $"D-Pad/DownButton"
@onready var leftButton = $"D-Pad/LeftButton"
@onready var rightButton = $"D-Pad/RightButton"

var dpadBoundaryTopLeft = Vector2(12, 32)
var dPadBoundaryBottomRight = Vector2(90,109)

#Buttons
@onready var aButton = $"A + B/AButton"
@onready var bButton = $"A + B/BButton"

@onready var touchParticles = $TouchParticles

func _process(delta: float) -> void:
	#No Press
	if upButton.is_pressed() == false and leftButton.is_pressed() == false and rightButton.is_pressed() == false and downButton.is_pressed() == false:
		dPadSprite.frame = 8
	#Up Only
	if upButton.is_pressed() and leftButton.is_pressed() == false and rightButton.is_pressed() == false:
		dPadSprite.frame = 0
	#Right Only
	if rightButton.is_pressed() and upButton.is_pressed() == false and downButton.is_pressed() == false:
		dPadSprite.frame = 1
	#Down Only
	if downButton.is_pressed() and leftButton.is_pressed() == false and rightButton.is_pressed() == false:
		dPadSprite.frame = 2
	#Left Only
	if leftButton.is_pressed() and upButton.is_pressed() == false and downButton.is_pressed() == false:
		dPadSprite.frame = 3
	##Up Right
	if upButton.is_pressed() and rightButton.is_pressed():
		dPadSprite.frame = 4
	##Down Right
	if downButton.is_pressed() and rightButton.is_pressed():
		dPadSprite.frame = 5
	##Down Left
	if downButton.is_pressed() and leftButton.is_pressed():
		dPadSprite.frame = 6
	##Up Left
	if upButton.is_pressed() and leftButton.is_pressed():
		dPadSprite.frame = 7
