extends CharacterBody2D
class_name Player

signal create_pulse(pulse_position)

var light
var light_radius = 20
var tween
var direction
var pulse_cooldown_timer: Timer
var can_pulse = true
@export var pulse_cooldown = 2
@onready var animation_tree: AnimationTree = $AnimationTree

# Called when the node enters the scene tree for the first time.
func _ready():
	pulse_cooldown_timer = Timer.new()
	pulse_cooldown_timer.wait_time = pulse_cooldown
	pulse_cooldown_timer.one_shot = true
	pulse_cooldown_timer.connect("timeout", _on_pulse_cooldown_timeout)
	add_child(pulse_cooldown_timer)
	animation_tree.active = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_animation_parameters()		
	
func _physics_process(delta):
	direction = Input.get_vector("move_left","move_right","move_up","move_down").normalized()
	velocity = direction * 50
	move_and_slide()
	if Input.is_action_just_pressed("a_button") and can_pulse:
		create_pulse.emit(position)
		can_pulse = false
		pulse_cooldown_timer.start()

func update_animation_parameters():
	animation_tree["parameters/conditions/idle"] = true if velocity == Vector2.ZERO else false
	animation_tree["parameters/conditions/is_walking"] = true if velocity != Vector2.ZERO else false
	animation_tree["parameters/conditions/pulse"] = true if Input.is_action_just_pressed("a_button") else false	
	
	if (direction != Vector2.ZERO):
		animation_tree["parameters/idle/blend_position"] = direction
		animation_tree["parameters/walk/blend_position"] = direction
		animation_tree["parameters/pulse/blend_position"] = direction

func _on_pulse_cooldown_timeout():
	can_pulse = true
