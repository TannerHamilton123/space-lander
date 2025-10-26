extends CharacterBody2D

signal bad_landing
signal good_landing



const GRAVITY = Vector2(0,20.0)
 #must be float for it to function with delta
var speed : int
var test_var : float
var landed : bool = false
var rotation_speed : float = 0
var rotation_to_landing : int

var thrust_power : float = .5
var THRUST = Vector2(0,-thrust_power)
var landing_speed  : float = 15
var landing_rotation : float = 15
var rotational_thrust : float = 0.01
var FUEL : float = 200

@onready var lander_rotation = $"../landing_platform".rotation_degrees
func _ready():
	#if $"../platform_landing":
	
	var saved_color : Color = Global.player_color
	$Sprite2D.modulate = saved_color
	velocity = Vector2(10,0)
	
func _physics_process(delta: float) -> void:
	$thrust_emission.emitting = false
	$right_emission.emitting = false
	$left_emission.emitting = false
	speed = velocity.length()
	velocity += get_gravity() * delta

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
		$thrust_emission.emitting = true
		

	if Input.is_action_just_pressed("accept"):
		get_tree().reload_current_scene()
	if Input.is_action_pressed("right"):
		rotation_speed += rotational_thrust * delta
		$left_emission.emitting = true
	if Input.is_action_pressed("left"):
		rotation_speed -= rotational_thrust * delta
		$right_emission.emitting = true

func check_landing():
	if speed > landing_speed or abs(rotation_degrees - lander_rotation) > abs(landing_rotation):
		emit_signal("bad_landing")
	else:
		#$"../completed/SCORE".text = str("SCORE: " ,int(100 - speed*2 - rotation_to_landing*2))
		emit_signal("good_landing")
