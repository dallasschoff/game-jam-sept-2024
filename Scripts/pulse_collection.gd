extends Node
class_name PulseCollection

#This array stores the nodes
var pulses : Array[Pulse] = [null,null,null]

var PulseScene: PackedScene = load("res://Scenes/Pulse.tscn")

func create_pulse(pulse_position : Vector2): #Called by signal in player.gd
	Global.level.shaderMat.set_shader_parameter("start_frame", Engine.get_process_frames())
	var pulse = PulseScene.instantiate()
	pulse.position = pulse_position
	Global.level.add_child(pulse)
	_add_pulse(pulse)
	#if (len(pulses) == 1):
		#Global.mobileUI._update_pulse_fire_ui(1)
	#if (len(pulses) == 2):
		#Global.mobileUI._update_pulse_fire_ui(2)
	#if (len(pulses) == 3):
		#Global.mobileUI._update_pulse_fire_ui(3)
	if (len(pulses) > 3):
		##Remove the first pulse in the group
		#Global.mobileUI._update_pulse_fire_ui(4)
		#Shrink the fire away
		var scaleTween = Global.level.get_tree().create_tween()
		scaleTween.tween_property(pulses[3], "scale", Vector2(0.1,0.1), 0.5)
		scaleTween.tween_callback(_remove_oldest_pulse)
	#Better way of priting pulses
	#for i in pulses:
		#if i != null:
			#var node_name = i.name
			#var integer_hash = (node_name.hash() * 75 % 65537) - 1
			#print("position ", Global.pulseCollection.pulses.find(i, 0),", Node:",integer_hash)


func _remove_oldest_pulse():
	if pulses[3] != null:
		pulses[3].queue_free()
		Global.mobileUI._remove_pulse_fire_ui()
	pulses.remove_at(3)#[3] = null #This used to be remove_at(), but we want to keep the size at 3
	print("pulses",pulses)
	#Better way of priting pulses
	#var pulsesPrint = []
	#for i in pulses:
		#if i != null:
			#var node_name = i.name
			#var integer_hash = (node_name.hash() * 75 % 65537) - 1
			#print("position ", Global.pulseCollection.pulses.find(i, 0),", Node:",integer_hash)
	
func _add_pulse(pulse : Pulse): #Called by Player
	#Don't want to push front if 0 is null. Want new to take the place of null.
	#Also don't want to push front if 1 is null. We want 0 to become 1, and 2 to stay
	if pulses[0] != null and pulses[1] != null:
		#Push front if there's something there
		pulses.push_front(pulse)
	if pulses[0] != null and pulses[1] == null:
		pulses[1] = pulses[0]
		pulses[0] = pulse
	#If position 0 is empty, Puts the new pulse as position 0
	if pulses[0] == null: 
		pulses[0] = pulse
	Global.mobileUI._add_pulse_fire_ui()
	#_fix_stack()

func _remove_pulse_at(index): #Called by MobileUI when in fireDeleteMode
	if pulses[index] != null:
		pulses[index].queue_free()
	pulses[index] = null #This used to be remove_at(), but we want to keep the size at 3
	Global.mobileUI._remove_pulse_fire_ui()

#func _fix_stack():
	#for pulse in pulses:
		##canFix prevents it all from looping
		#var canFix = true
		#if pulse != null:
			##Move slot 1 if it's full
			#if pulse.uiSlot == 1 and pulses[0] != null and canFix: 
				#canFix = false
				#pulse.uiSlot = 2
				#pulse.uiPosition.x = pulse.uiPosition.x - 16
			##If there is something in slot 1, we need to move slot 2
			#if pulse.uiSlot == 2 and pulses[1] != null and canFix:
				#canFix = false
				#pulse.uiSlot = 3
				#pulse.uiPosition.x = pulse.uiPosition.x - 16
			##If there is something in slot 2, we need to move slot 3
			#if pulse.uiSlot == 3 and pulses[2] != null and canFix:
				#canFix = false
				#pulse.uiSlot = 4
				#pulse.uiPosition.x = pulse.uiPosition.x - 16

func _get_pulse_positions() -> Array[Vector2]:
	var positions : Array[Vector2]= [Vector2(-500, -500), Vector2(-500, -500), Vector2(-500, -500)]
	for i in range(3):#pulses.size():
		if pulses[i] == null:
			continue
		positions[i] = pulses[i].position
	#print("pulse_positions",positions)
	return positions
