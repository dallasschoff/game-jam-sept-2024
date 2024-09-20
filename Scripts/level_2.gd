extends Level

var limit_left = 0
var limit_right = 960
var limit_top = 0
var limit_bottom = 1008

func _ready():
	shaderMat = shader.material
	player.connect("create_pulse", create_pulse)
	player.connect("transition_finished", change_level)
	shaderMat.set_shader_parameter("pulseSpeed", pulseSpeed)
	
	player.camera.limit_left = limit_left
	player.camera.limit_right = limit_right
	player.camera.limit_top = limit_top
	player.camera.limit_bottom = limit_bottom
