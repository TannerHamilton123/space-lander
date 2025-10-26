extends Node2D

var end_x :int = 1200
var end_y : int = 800
var topo_points = 100
var topo_array : Array = [Vector2(0,int(end_y/2))]
var bottom_limit: int = 200
var top_limit : int = end_y - 200
var landing_x : int
var landing_y : int
var landing_size : int
var landing_half_width : int
var slope = 0
@onready var landing_platform = $landing_platform
@onready var lander = $lander
@onready var bounds = $bounds
@onready var explosion_scene = load("res://scenes/explosion.tscn")
 
func _ready() -> void:
	bounds.body_entered.connect(_on_bounds_body_entered)
	lander.bad_landing.connect(game_over)
	lander.good_landing.connect(completed)       

func _physics_process(delta: float) -> void:
	update_labels()

func _on_topo_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print('impact')
		game_over()

func _on_bounds_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):

		game_over()
		
func game_over() -> void:
	var explosion = explosion_scene.instantiate()
	explosion.position = lander.position
	explosion.play()
	$GameOver.show()
	get_tree().paused = true

func completed():
	$completed.show()
	get_tree().paused = true

func update_labels():
	lander.rotation_to_landing  = lander.rotation_degrees - $"landing_platform".rotation_degrees
	$"lander_labels/ROTATION".text = str(int(lander.rotation_to_landing),"°")
	if abs(lander.rotation_to_landing) > lander.landing_rotation:
		$"lander_labels/ROTATION".set("theme_override_colors/font_color",Color.RED)
	else:
		$"lander_labels/ROTATION".set("theme_override_colors/font_color",Color.GREEN)
	
	
	$"lander_labels/SPEED".text = str(lander.speed,"mp/h")
	if lander.speed > lander.landing_speed:
		$"lander_labels/SPEED".set("theme_override_colors/font_color",Color.RED)
	else:
		$"lander_labels/SPEED".set("theme_override_colors/font_color",Color.GREEN)
			
	$"UI/FUEL_LEVEL".value = lander.FUEL
