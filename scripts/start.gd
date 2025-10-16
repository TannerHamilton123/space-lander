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

@onready var landing_location = load("res://scenes/landing_platform.tscn").instantiate()

 
func _ready() -> void:
	add_child(landing_location)
	
	make_landing()
	make_topo()
	validate_landing()       
 
func make_topo():
	for i in range(1,topo_points):
		var slope = randi_range(-100,100)

		var x : int = topo_array[i-1][0] + (end_x  / topo_points)
		var y : int= topo_array[i-1][1] + slope
		if y < bottom_limit:
			y = bottom_limit
		if y > top_limit:
			y = top_limit
		if x in range(landing_x-landing_half_width,landing_x+landing_half_width):
			y = landing_y+5
		topo_array.append(Vector2(x,y))


	var topo = Line2D.new()
	
	add_child(topo)
	topo.points = topo_array
	
	topo_array.append(Vector2(end_x,end_y))
	topo_array.push_front(Vector2(0,800))
	
	$topo_area/CollisionPolygon2D.set_polygon(topo_array)
   
	

func make_landing():
	
	
	landing_location.position.x = randi_range(0,end_x)
	landing_location.position.y = randi_range(bottom_limit,top_limit)
	var collision_shape = landing_location.get_node("PhysicalPad/collision")
	landing_half_width = collision_shape.shape.extents[0]
	landing_x = landing_location.position.x
	landing_y = landing_location.position.y
	
func validate_landing():
	var ClearanceArea = landing_location.get_node("ClearanceArea")
	ClearanceArea.too_fast.connect(game_over)
	if is_instance_valid(ClearanceArea):
		ClearanceArea.too_fast.connect(game_over)
		


func _on_topo_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		game_over()

func _on_bounds_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		game_over()
		
func game_over() -> void:
	$GameOver.show()
	get_tree().paused = true
