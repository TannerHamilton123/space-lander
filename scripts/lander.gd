extends CharacterBody2D

signal too_fast

const THRUST = Vector2(0,-1.0)
const GRAVITY = Vector2(0,20.0)
var FUEL : float = 100 #must be float for it to function with delta
var speed : int
var test_var : float
var landed : bool = false

@onready var landing_ray = $RayCast2D
func _ready():
	velocity = Vector2(10,0)

func _physics_process(delta: float) -> void:
	speed = velocity.length()
	controls(delta)
	
	$"../UI/ROTATION".text = str(int(rotation_degrees),"°")
	$"../UI/SPEED".text = str(speed,"mp/h")
	$"../UI/ProgressBar".value = FUEL
	
	
	velocity += GRAVITY * delta
	
	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.get_collider().name == "PhysicalPad" and not landed:
			landed = true
			check_landing()
	
	
func controls(delta):
	if Input.is_action_pressed("thrust") and FUEL > 0:
		velocity += THRUST.rotated(self.rotation)
		FUEL -= delta * 10

	if Input.is_action_just_pressed("accept"):
		get_tree().reload_current_scene()

	if Input.is_action_pressed("right"):
		self.rotation += 0.01
	if Input.is_action_pressed("left"):
		self.rotation -= 0.01


func check_landing():
	if speed > 20 or rotation_degrees > abs(45):
		print("bad landing",speed,rotation_degrees)
		emit_signal("too_fast")
	else:
		print("good landing",speed,rotation_degrees)
		
		get_tree().reload_current_scene()
