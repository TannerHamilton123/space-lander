extends CharacterBody2D


const SPEED = 300.0
const THRUST = Vector2(0,-1.0)
const GRAVITY = Vector2(0,20.0)
var FUEL : float = 100 #must be float for it to function with delta


var test_var : float
func _physics_process(delta: float) -> void:
	# Add the gravity.
	$"../Control/ProgressBar".value = FUEL
	velocity += GRAVITY * delta

	# Handle jump.
	if Input.is_action_pressed("thrust"):
		velocity += THRUST.rotated(self.rotation)
		FUEL -= delta * 10

	if Input.is_action_just_pressed("accept"):
		get_tree().reload_current_scene()

	if Input.is_action_pressed("right"):
		self.rotation += 0.01
	if Input.is_action_pressed("left"):
		self.rotation -= 0.01
	move_and_slide()
	
