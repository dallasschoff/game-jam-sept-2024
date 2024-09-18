extends Node2D

@onready var player = $Player
@onready var shader = $ColorRect
@export var PulseScene: PackedScene
# To find correct number: ratio of modulo and speed should be ratio or 12 / 5 (modulo / pulseSpeed)
@export var pulseSpeed = 5.5

var player_position : Vector2;
var shaderMat
var pulse_positions : Array[Vector2] = [ Vector2(-500, -500), Vector2(-500, -500) ]
var burnable_positions : Array[Vector2]
var burnable_states : Array[bool]
var burnable_start_frames : Array[float]
var burnable_radii : Array[float]
var burnable_glow_speeds : Array[float]

func _ready():
	shaderMat = shader.material
	player.connect("create_pulse", create_pulse)
	shaderMat.set_shader_parameter("pulseSpeed", pulseSpeed)

func _process(delta):
	shaderMat.set_shader_parameter("player_position", player.position)
	shaderMat.set_shader_parameter("current_frame", Engine.get_process_frames())
	update_burnables()
	shaderMat.set_shader_parameter("burnable_positions", burnable_positions)
	shaderMat.set_shader_parameter("burnable_states", burnable_states)
	shaderMat.set_shader_parameter("burnable_start_frames", burnable_start_frames)
	shaderMat.set_shader_parameter("burnable_radii", burnable_radii)
	shaderMat.set_shader_parameter("burnable_glow_speeds", burnable_glow_speeds)
	shaderMat.set_shader_parameter("pulse_positions", pulse_positions)

func create_pulse(pulse_position : Vector2):
	shaderMat.set_shader_parameter("start_frame", Engine.get_process_frames())
	var pulse = PulseScene.instantiate()
	pulse.position = pulse_position
	add_child(pulse)
	var pulses = get_tree().get_nodes_in_group("Pulses")
	pulses.remove_at(0)
	if (len(pulses) > 2):
		pulses[0].queue_free()
	pulse_positions.remove_at(0)
	pulse_positions.push_back(pulse_position)

#Get new information on whether a given burnable on the level is lit and its position in the level
func update_burnables():
	burnable_positions.clear()
	burnable_states.clear()
	burnable_start_frames.clear()
	burnable_radii.clear()
	burnable_glow_speeds.clear()
	var level_burnables = get_tree().get_nodes_in_group("Burnables")
	level_burnables.remove_at(0)
	for burnable in level_burnables:
		burnable_positions.push_back(burnable.position)
		burnable_states.push_back(burnable.lit)
		burnable_start_frames.push_back(burnable.start_frame)
		burnable_radii.push_back(burnable.burn_radius)
		burnable_glow_speeds.push_back(burnable.glow_speed)
