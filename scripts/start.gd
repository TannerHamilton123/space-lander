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
@onready var entry_labels = $entry_labels
 
func _ready() -> void:
	print(lander.landing_rotation)
	bounds.body_entered.connect(_on_bounds_body_entered)
	lander.bad_landing.connect(game_over)
	lander.good_landing.connect(completed) 
	
	

func _physics_process(delta: float) -> void:
	update_labels()

func _on_topo_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		game_over()

func _on_bounds_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):

		game_over()
		
func game_over() -> void:
	$GameOver.show()
	get_tree().paused = true

func completed():
	$completed.show()
	get_tree().paused = true

func update_labels():
	#var landing_platform = $landing_platform
	#var lander = $lander
	var speed_label = $entry_labels/ROTATION
	var rotation_label = $entry_labels/SPEED
	
	#var landing_rot : int = lander.landing_rotation
	#var rotation_to_landing  = lander.rotation_degrees - landing_platform.rotation_degrees
	#rotation_label.text = str(int(rotation_to_landing),"°")
	#if abs(rotation_to_landing) > landing_rot:
		#rotation_label.set("theme_override_colors/font_color",Color.RED)
	#else:
		#rotation_label.set("theme_override_colors/font_color",Color.GREEN)
	#
	#var speed = lander.speed
	#var landing_speed = lander.landing_speed
	#var FUEL = lander.FUEL
	#speed_label.text = str(speed,"mp/h")
	#if speed > landing_speed:
		#speed_label.set("theme_override_colors/font_color",Color.RED)
	#else:
		#speed_label.set("theme_override_colors/font_color",Color.GREEN)
			#
	#$UI/ProgressBar.value = FUEL

func place_labels():
	entry_labels.position = Vector2(landing_x,landing_y)
	entry_labels.rotation = landing_platform.rotation
#func place_labels
#entry_labels/$SPEED = landing_platform.position + Vector2(-landing_size[0]/2,25).rotated(landing_platform.get_node("PhysicalPad/collision").rotation)
#$"UI/SPEED".position = landing_platform.position + Vector2(-landing_size[0]/2,50).rotated(landing_platform.get_node("PhysicalPad/collision").rotation)
