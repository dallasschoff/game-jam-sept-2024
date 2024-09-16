extends CharacterBody2D

var light
var light_radius = 20
var tween
@onready var animation_tree: AnimationTree = $AnimationTree
var direction
signal create_pulse(pulse_position)

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_tree.active = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_animation_parameters()
	
func _physics_process(delta):
	direction = Input.get_vector("move_left","move_right","move_up","move_down").normalized()
	velocity = direction * 50
	move_and_slide()
	if Input.is_action_just_pressed("a_button"):
		create_pulse.emit(position)

func update_animation_parameters():
	animation_tree["parameters/conditions/idle"] = true if velocity == Vector2.ZERO else false
	animation_tree["parameters/conditions/is_walking"] = true if velocity != Vector2.ZERO else false
	animation_tree["parameters/conditions/pulse"] = true if Input.is_action_just_pressed("a_button") else false	
	
	print(direction)
	if (direction != Vector2.ZERO):
		animation_tree["parameters/idle/blend_position"] = direction
		animation_tree["parameters/walk/blend_position"] = direction
		animation_tree["parameters/pulse/blend_position"] = direction
	
