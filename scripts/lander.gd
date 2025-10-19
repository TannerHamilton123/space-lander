extends CharacterBody2D

signal bad_landing
signal good_landing

const THRUST = Vector2(0,-1.0)
const GRAVITY = Vector2(0,20.0)
var FUEL : float = 100 #must be float for it to function with delta
var speed : int
var test_var : float
var landed : bool = false
var rotation_speed : float = 0

@export var landing_speed  : float
@export var landing_rotation : float
@export var rotational_thrust : float
func _ready():
	velocity = Vector2(10,0)

func _physics_process(delta: float) -> void:
	speed = velocity.length()
	updated_labels()
	controls(delta)
	
	
	velocity += GRAVITY * delta
	
	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.get_collider().name == "PhysicalPad" and not landed:
			landed = true
			check_landing()
	rotation += rotation_speed
	
func controls(delta):
	if Input.is_action_pressed("thrust") and FUEL > 0:
		velocity += THRUST.rotated(self.rotation)
		FUEL -= delta * 10

	if Input.is_action_just_pressed("accept"):
		get_tree().reload_current_scene()

	if Input.is_action_pressed("right"):
		#self.rotation += 0.01
		rotation_speed += rotational_thrust
		print(rotational_thrust)
	if Input.is_action_pressed("left"):
		#self.rotation -= 0.01
		#self.rotational_velocity -= 0.01
		rotation_speed -= rotational_thrust


func check_landing():
	if speed > landing_speed or rotation_degrees > abs(landing_rotation):
		emit_signal("bad_landing")
	else:

		$"../completed/SCORE".text = str("SCORE: " ,int(100 - speed*2 - rotation_degrees*2))
		emit_signal("good_landing")


func updated_labels():
		$"../UI/ROTATION".text = str(int(rotation_degrees),"°")
		if abs(rotation_degrees) > landing_rotation:
			$"../UI/ROTATION".set("theme_override_colors/font_color",Color.RED)
		else:
			$"../UI/ROTATION".set("theme_override_colors/font_color",Color.GREEN)
		
		
		$"../UI/SPEED".text = str(speed,"mp/h")
		if speed > landing_speed:
			$"../UI/SPEED".set("theme_override_colors/font_color",Color.RED)
		else:
			$"../UI/SPEED".set("theme_override_colors/font_color",Color.GREEN)
			
		$"../UI/ProgressBar".value = FUEL
		
		
		
