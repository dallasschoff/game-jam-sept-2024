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

#PulseUI
@onready var pulseFireUI = load("res://Scenes/PulseFireUI.tscn")

var pulseFireInUISlot1
var firePos1 = Vector2(115, 14)
var pulseFireInUISlot2
var firePos2 = Vector2(131, 14)
var pulseFireInUISlot3
var firePos3 = Vector2(147, 14)
var pulseFireInUISlot4
var trash = Vector2(147, 28)


var fireDeleteMode : bool = false
var canDisappear = false
@onready var selectorIcon = $UI/SelectorIcon
var canMove
var slot1Pos = Vector2(35.0, -58.0)
var slot2Pos = Vector2(51.0, -58.0)
var slot3Pos = Vector2(67.0, -58.0)

var canToggle = true

func _ready() -> void:
	Global.mobileUI = self

func _process(delta: float) -> void:
	_dpad_visuals()
	
	#A Button Confirms deleting a fire if in fireDeleteMode
		#Need just_released or else you'll create a fire while deleting a fire
	if fireDeleteMode and Input.is_action_just_released("a_button"):
		_delete_fire()
	
	if fireDeleteMode == true:
		_fire_delete_mode()
		$"A + B/DeleteButton".visible = true
		$"A + B/DeleteButton".rotation_degrees = $"A + B/DeleteButton".rotation_degrees + 2
		$"LR Buttons".visible = true
	
	if fireDeleteMode == false:
		$"A + B/DeleteButton".visible = false
		$"LR Buttons".visible = false

		if Global.pulseCollection.pulses[0] != null:
			Global.pulseCollection.pulses[0].selectorIcon.visible = false
		if Global.pulseCollection.pulses[1] != null:
			Global.pulseCollection.pulses[1].selectorIcon.visible = false
		if Global.pulseCollection.pulses[2] != null:
			Global.pulseCollection.pulses[2].selectorIcon.visible = false

func _toggle_delete_mode():
	fireDeleteMode = !fireDeleteMode
	Global.fireDeleteMode = !Global.fireDeleteMode
	
	#Selector Animations 
	if !fireDeleteMode:
		selectorIcon.stop()
		selectorIcon.play("disappear")
		if Global.pulseCollection.pulses[0] != null:
			if selectorIcon.position == slot1Pos:
				Global.pulseCollection.pulses[0]._play_disappear_anim()
		if Global.pulseCollection.pulses[1] != null:
			if selectorIcon.position == slot2Pos:
				Global.pulseCollection.pulses[1]._play_disappear_anim()
		if Global.pulseCollection.pulses[2] != null:
			if selectorIcon.position == slot3Pos:
				Global.pulseCollection.pulses[2]._play_disappear_anim()
	if fireDeleteMode:
		selectorIcon.position = slot1Pos
		selectorIcon.stop()
		selectorIcon.play("appear")
		if Global.pulseCollection.pulses[0] != null:
			if selectorIcon.position == slot1Pos:
				Global.pulseCollection.pulses[0].selectorIcon.play("appear")
		if Global.pulseCollection.pulses[1] != null:
			if selectorIcon.position == slot2Pos:
				Global.pulseCollection.pulses[1].selectorIcon.play("appear")
		if Global.pulseCollection.pulses[2] != null:
			if selectorIcon.position == slot3Pos:
				Global.pulseCollection.pulses[2].selectorIcon.play("appear")
		
	#if selectorIcon.visible == true and canDisappear:
		#selectorIcon.play("disappear")
	#if selectorIcon.visible == false and !canDisappear:
		#selectorIcon.visible = true
		#selectorIcon.play("appear")
		#canDisappear = true
	
func _on_selector_icon_animation_finished() -> void:
	pass
	#if selectorIcon.animation == "appear":
		#selectorIcon.visible == true
		#canDisappear = true
	#if selectorIcon.animation == "disappear":
		#selectorIcon.visible == false
		#canDisappear = false

func _fire_delete_mode():
#Left / Right movements along the three UI slots.
	#Starts you on 1
	selectorIcon.visible = true
	canMove = true
	if selectorIcon.position == slot1Pos:
		if Input.is_action_just_pressed("move_left") and canMove:
			selectorIcon.position = slot3Pos
			canMove = false
		if Input.is_action_just_pressed("move_right") and canMove:
			selectorIcon.position = slot2Pos
			canMove = false
	if selectorIcon.position == slot2Pos:
		if Input.is_action_just_pressed("move_left") and canMove:
			selectorIcon.position = slot1Pos
			canMove = false
		if Input.is_action_just_pressed("move_right") and canMove:
			selectorIcon.position = slot3Pos
			canMove = false
	if selectorIcon.position == slot3Pos:
		if Input.is_action_just_pressed("move_left") and canMove:
			selectorIcon.position = slot2Pos
			canMove = false
		if Input.is_action_just_pressed("move_right") and canMove:
			selectorIcon.position = slot1Pos
			canMove = false

#Visual indicator on the fires in the level space
	if Global.pulseCollection.pulses[0] != null:
		if selectorIcon.position == slot1Pos:
			Global.pulseCollection.pulses[0].selectorIcon.visible = true
		else: Global.pulseCollection.pulses[0].selectorIcon.visible = false
	if Global.pulseCollection.pulses[1] != null:
		if selectorIcon.position == slot2Pos:
			Global.pulseCollection.pulses[1].selectorIcon.visible = true
		else: Global.pulseCollection.pulses[1].selectorIcon.visible = false
	if Global.pulseCollection.pulses[2] != null:
		if selectorIcon.position == slot3Pos:
			Global.pulseCollection.pulses[2].selectorIcon.visible = true
		else: Global.pulseCollection.pulses[2].selectorIcon.visible = false

func _delete_fire():
	if selectorIcon.position == slot1Pos:
		if Global.pulseCollection.pulses[0] != null:
			Global.pulseCollection.pulses[0]._play_delete_anim()
			Global.pulseCollection._remove_pulse_at(0)
		selectorIcon.play("delete")
		if pulseFireInUISlot1 != null:
			pulseFireInUISlot1.queue_free()
	if selectorIcon.position == slot2Pos:
		if Global.pulseCollection.pulses[1] != null:
			Global.pulseCollection.pulses[1]._play_delete_anim()
			Global.pulseCollection._remove_pulse_at(1)
		selectorIcon.play("delete")
		if pulseFireInUISlot2 != null:
			pulseFireInUISlot2.queue_free()
	if selectorIcon.position == slot3Pos:
		if Global.pulseCollection.pulses[2] != null:
			Global.pulseCollection.pulses[2]._play_delete_anim()
			Global.pulseCollection._remove_pulse_at(2)
		selectorIcon.play("delete")
		if pulseFireInUISlot3 != null:
			pulseFireInUISlot3.queue_free()
	fireDeleteMode = false
	Global.fireDeleteMode = false
	#selectorIcon.visible = false


func _remove_pulse_fire_ui():#Want to call from pulse_collections
	print("TESTING UI REMOVE",Global.pulseCollection.pulses)
	
	
func _add_pulse_fire_ui():#Want to call from pulse_collections
	var pulseFireUIinstance = pulseFireUI.instantiate()
	add_child(pulseFireUIinstance)
	
	#Move all the slots along if necessary
	if pulseFireInUISlot3 != null and pulseFireInUISlot2 != null and pulseFireInUISlot1 != null:
		pulseFireInUISlot4 = pulseFireInUISlot3
		var posTween = get_tree().create_tween()
		posTween.tween_property(pulseFireInUISlot3, "position", trash, 0.5)
	if pulseFireInUISlot2 != null and pulseFireInUISlot1 != null:
		pulseFireInUISlot3 = pulseFireInUISlot2
		var posTween = get_tree().create_tween()
		posTween.tween_property(pulseFireInUISlot2, "position", firePos3, 0.5)
	if pulseFireInUISlot1 != null:
		pulseFireInUISlot2 = pulseFireInUISlot1
		var posTween = get_tree().create_tween()
		posTween.tween_property(pulseFireInUISlot1, "position", firePos2, 0.5)
	pulseFireInUISlot1 = pulseFireUIinstance
	#Start it super small
	pulseFireUIinstance.scale = Vector2(0.1,0.1)
	pulseFireUIinstance.position = firePos1
	#Anim to make it appear
	var scaleTween = get_tree().create_tween()
	scaleTween.tween_property(pulseFireUIinstance, "scale", Vector2(1.0,1.0), 0.5)
	
	await 0.5
	if pulseFireInUISlot4 != null:
		var scaleTweenTrash = get_tree().create_tween()
		scaleTweenTrash.tween_property(pulseFireInUISlot4, "scale", Vector2(0.1,0.1), 0.5)
		await scaleTweenTrash.finished 
		pulseFireInUISlot4.queue_free()

func _dpad_visuals():
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
