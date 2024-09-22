extends Level

var limit_left = 0
var limit_right = 960
var limit_top = 0
var limit_bottom = 1008

@onready var currentLitTotems = 0

var doorOpened : bool = false

signal allTotemsLit

func _ready():
	var currentLitTotems = 0
	
	shaderMat = shader.material
	player.connect("create_pulse", create_pulse)
	player.connect("transition_finished", change_level)
	shaderMat.set_shader_parameter("pulseSpeed", pulseSpeed)
	
	player.camera.limit_left = limit_left
	player.camera.limit_right = limit_right
	player.camera.limit_top = limit_top
	player.camera.limit_bottom = limit_bottom

func _process(delta):
	# Inherited from parent scene
	shaderMat.set_shader_parameter("player_position", player.position)
	shaderMat.set_shader_parameter("current_frame", Engine.get_process_frames())
	update_burnables()
	shaderMat.set_shader_parameter("burnable_positions", burnable_positions)
	shaderMat.set_shader_parameter("burnable_states", burnable_states)
	shaderMat.set_shader_parameter("burnable_start_frames", burnable_start_frames)
	shaderMat.set_shader_parameter("burnable_radii", burnable_radii)
	shaderMat.set_shader_parameter("burnable_glow_speeds", burnable_glow_speeds)
	shaderMat.set_shader_parameter("pulse_positions", pulse_positions)
	
	# Updating door based on totem lit status
	updateTotemDoor()

# Recurs through totems and lights up associated circle
func updateTotemDoor():
	currentLitTotems = 0
	var levelTotems = get_tree().get_nodes_in_group("DoorTotems")
	var doorCircles = get_tree().get_nodes_in_group("DoorCircles")
	var totemIterator = levelTotems.size()
	for i in totemIterator:
		if levelTotems[i].lit && not doorOpened:
			doorCircles[i].show()
			currentLitTotems += 1
		else:
			doorCircles[i].hide()
			
	if currentLitTotems == 5 && not doorOpened:
		allTotemsLit.emit()
		doorOpened = true
		
	
	
