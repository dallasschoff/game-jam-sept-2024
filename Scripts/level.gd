extends Node

var player_position : Vector2;
@onready var player = $Player
@onready var shader = $ColorRect
var shaderMat

var material : Shader = load("res://Scenes/lighting.gdshader")

func _ready():
	shaderMat = shader.material
	#shaderMat.set_shader_parameter("player_position",player_position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	player_position = player.position
	shaderMat.set_shader_parameter("player_position",player_position)
