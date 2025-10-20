extends CharacterBody2D

signal bad_landing
signal good_landing

@export var thrust_power : float = .5
var THRUST = Vector2(0,-thrust_power)
const GRAVITY = Vector2(0,20.0)
var FUEL : float = 100 #must be float for it to function with delta
var speed : int
var test_var : float
var landed : bool = false
var rotation_speed : float = 0
var rotation_to_landing : int

@export var landing_speed  : float
@export var landing_rotation : float
@export var rotational_thrust : float
func _ready():
	var saved_color : Color = Global.player_color
	$Sprite2D.modulate = saved_color
	velocity = Vector2(10,0)
	

func _physics_process(delta: float) -> void:
	speed = velocity.length()
	velocity += get_gravity() * delta
	updated_labels()
	controls(delta)
	
	
	
	
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
		rotation_speed += rotational_thrust
	if Input.is_action_pressed("left"):
		rotation_speed -= rotational_thrust


func check_landing():
	if speed > landing_speed or rotation_to_landing > abs(landing_rotation):
		emit_signal("bad_landing")
	else:

		$"../completed/SCORE".text = str("SCORE: " ,int(100 - speed*2 - rotation_to_landing*2))
		emit_signal("good_landing")


func updated_labels():
	rotation_to_landing  = rotation_degrees - $"../landing_platform".rotation_degrees
	$"../UI/ROTATION".text = str(int(rotation_to_landing),"°")
	if abs(rotation_to_landing) > landing_rotation:
		$"../UI/ROTATION".set("theme_override_colors/font_color",Color.RED)
	else:
		$"../UI/ROTATION".set("theme_override_colors/font_color",Color.GREEN)
	
	
	$"../UI/SPEED".text = str(speed,"mp/h")
	if speed > landing_speed:
		$"../UI/SPEED".set("theme_override_colors/font_color",Color.RED)
	else:
		$"../UI/SPEED".set("theme_override_colors/font_color",Color.GREEN)
			
	$"../UI/ProgressBar".value = FUEL
