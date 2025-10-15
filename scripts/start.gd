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

func _ready() -> void:
	make_landing()
	make_topo()
	pass # Replace with function body.

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
	#print(range(landing_x-200,landing_x+200))

		
	var topo = Line2D.new()
	
	add_child(topo)
	topo.points = topo_array
	#$topo_collision_area/CollisionPolygon2D.size = topo_points
	$topo_area/CollisionPolygon2D.set_polygon(topo_array)
	

func make_landing():
	var landing_location = load("res://scenes/landing_platform.tscn").instantiate()
	add_child(landing_location)
	landing_location.position.x = randi_range(0,end_x)
	landing_location.position.y = randi_range(bottom_limit,top_limit)
	var collision_shape = landing_location.get_node("Area2D/collision")
	landing_half_width = collision_shape.shape.extents[0]
	landing_x = landing_location.position.x
	landing_y = landing_location.position.y
	



func _on_topo_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_tree().reload_current_scene()
