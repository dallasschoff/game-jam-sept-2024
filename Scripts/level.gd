extends Node2D
class_name Level

signal level_over
var nextLevel: PackedScene = load("res://Scenes/Level2.tscn")
@onready var player = $Player
@onready var music = $OST
@onready var shader = $ColorRect
@onready var level_end = $"Level End"
var PulseScene: PackedScene = load("res://Scenes/Pulse.tscn")
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
	player.connect("transition_finished", change_level)
	shaderMat.set_shader_parameter("pulseSpeed", pulseSpeed)
	player.collectibleCounter = 0
	var collectibles = get_tree().get_nodes_in_group("Collectibles")
	player.collectibleMax = len(collectibles)
	
	playMusic()

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

func _on_level_end_area_entered(area):
	if area.get_parent() is Player:
		player.increment_radius = false


func playMusic():
	await get_tree().create_timer(1).timeout
	music.volume_db = -20
	music.play()
	var fadeIn = get_tree().create_tween()
	fadeIn.tween_property(music,"volume_db",0,1.5)


func change_level():
	music.stop()
	get_tree().change_scene_to_packed(nextLevel)
