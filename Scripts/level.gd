extends Node2D

@onready var player = $Player
@onready var shader = $ColorRect
@export var PulseScene: PackedScene

# To find correct number: ratio of modulo and speed should be ratio or 12 / 5 (modulo / pulseSpeed)
@export var pulseSpeed = 5.5;

var player_position : Vector2;
var shaderMat
var torch_positions : Array[Vector2]
var torch_states : Array[bool]
var torch_start_frames : Array[float]

func _ready():
	shaderMat = shader.material
	player.connect("create_pulse", create_pulse)
	shaderMat.set_shader_parameter("pulseSpeed", pulseSpeed)

func _process(delta):
	shaderMat.set_shader_parameter("player_position", player.position)
	shaderMat.set_shader_parameter("current_frame", Engine.get_process_frames())
	update_torches()
	shaderMat.set_shader_parameter("torch_states", torch_states)
	shaderMat.set_shader_parameter("torch_positions", torch_positions)
	shaderMat.set_shader_parameter("torch_start_frames", torch_start_frames)
	

func create_pulse(pulse_position : Vector2):
	shaderMat.set_shader_parameter("pulse_position", pulse_position)
	shaderMat.set_shader_parameter("start_frame", Engine.get_process_frames())
	var pulse = PulseScene.instantiate()
	pulse.position = pulse_position
	add_child(pulse)

#Get new information on whether a given torch on the level is lit and its position in the level
func update_torches():
	torch_positions.clear()
	torch_start_frames.clear()
	var level_torches = get_tree().get_nodes_in_group("Torches")
	level_torches.remove_at(0)
	var i = 0
	for torch in level_torches:
		if (len(torch_states) == 5 and torch.start_frame > 0.0):
			torch_start_frames[i] = torch.start_frame
		else:
			torch_start_frames.push_back(0)
		torch_states.insert(i, torch.lit)
		torch_positions.push_back(torch.position)
		i += 1
