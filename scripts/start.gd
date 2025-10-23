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

 
func _ready() -> void:
	bounds.body_entered.connect(_on_bounds_body_entered)
	lander.bad_landing.connect(game_over)
	lander.good_landing.connect(completed) 
	var landing_size = $"landing_platform/PhysicalPad/collision".shape.size       
	$"UI/ROTATION".position = landing_platform.position + Vector2(-landing_size[0]/2,25).rotated(landing_platform.get_node("PhysicalPad/collision").rotation)
	$"UI/SPEED".position = landing_platform.position + Vector2(-landing_size[0]/2,50).rotated(landing_platform.get_node("PhysicalPad/collision").rotation)
	print(landing_platform.get_node("PhysicalPad/collision").rotation)
	
 

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
