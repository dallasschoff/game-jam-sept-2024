extends Node2D
class_name Pulse

@onready var animated_sprite = $Fire
var uiSlot = 1
var uiPosition = Vector2(147, 14)

@onready var selectorIcon = $SelectorIcon

var selectorIconInstancer = load("res://Scenes/SelectorIcon.tscn")
var selectorIconInstance

func _ready():
	add_to_group("Pulses")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	animated_sprite.play("pulse_ground_fire")

func _play_delete_anim(): #Called by MobileUI
	animated_sprite.play("delete")
	selectorIconInstance = selectorIconInstancer.instantiate() 
	get_parent().get_parent().add_child(selectorIconInstance)
	selectorIconInstance.visible = true
	selectorIconInstance.position = position
	selectorIconInstance.play("delete")

func _play_disappear_anim():
	selectorIconInstance = selectorIconInstancer.instantiate() 
	get_parent().get_parent().add_child(selectorIconInstance)
	selectorIconInstance.visible = true
	selectorIconInstance.position = position
	selectorIconInstance.play("disappear")
