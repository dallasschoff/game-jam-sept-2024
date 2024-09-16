extends Node2D

var player_position : Vector2;
@onready var player = $Player
@onready var shader = $ColorRect
var shaderMat
@export var PulseScene: PackedScene

func _ready():
	shaderMat = shader.material
	player.connect("create_pulse", create_pulse)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	shaderMat.set_shader_parameter("player_position", player.position)

func create_pulse(pulse_position : Vector2):
	shaderMat.set_shader_parameter("pulse_position", pulse_position)
	var pulse = PulseScene.instantiate()
	pulse.position = pulse_position
	add_child(pulse)
	
#func _draw():
	#draw_arc(player.position, 10.0, )
