extends CharacterBody2D

var light
var light_radius = 20
var tween
# Called when the node enters the scene tree for the first time.
func _ready():
	light = $PointLight2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = direction * 100
	
	move_and_slide()
	
	if Input.is_action_just_pressed("a_button"):
		tween = get_tree().create_tween()
		tween.tween_property(light, "position", Vector2(light.position.x - 100, light.position.y), 5)
	
func _physics_process(delta):
	pass
