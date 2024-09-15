extends Node2D

var player_position : Vector2;
@onready var player = $Player
@onready var shader = $ColorRect
var shaderMat
@export var PulseScene: PackedScene
# To find correct number: ratio of modulo and speed should be ratio or 12 / 5 (modulo / pulseSpeed)
@export var pulseSpeed = 5.5;


func _ready():
	shaderMat = shader.material
	player.connect("create_pulse", create_pulse)
	shaderMat.set_shader_parameter("pulseSpeed", pulseSpeed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	shaderMat.set_shader_parameter("player_position", player.position)
	shaderMat.set_shader_parameter("current_frame", Engine.get_process_frames())

func create_pulse(pulse_position : Vector2):
	shaderMat.set_shader_parameter("pulse_position", pulse_position)
	shaderMat.set_shader_parameter("start_frame", Engine.get_process_frames())
	var pulse = PulseScene.instantiate()
	pulse.position = pulse_position
	add_child(pulse)
