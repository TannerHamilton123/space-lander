extends Area2D

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
var point_index : int = 0
@onready var landing_platform = $"../landing_platform"
@onready var lander = $"../lander"
@onready var bounds = $"../bounds"
func _ready() -> void:
	get_tree().paused = true
	make_topo()
	
func make_topo():
	for i in range(1,topo_points):
		slope += randi_range(-10,10)

		var x : int = topo_array[i-1][0] + (end_x  / topo_points)
		var y : int= topo_array[i-1][1] + slope
		if y < bottom_limit:
			y = bottom_limit
			slope = 0
		if y > top_limit:
			y = top_limit
			slope = 0
		if x in range(landing_x-landing_half_width,landing_x+landing_half_width):
			y = landing_y+5
		topo_array.append(Vector2(x,y))

	topo_array.append(Vector2(end_x,end_y))
	topo_array.push_front(Vector2(0,800))
	
	#$topo.points = topo_array
	
	$CollisionPolygon2D.set_polygon(topo_array)
func make_landing():
	var rand_topo_point = randi_range(10,topo_points)
	landing_platform.position = topo_array[rand_topo_point]
	var collision_shape = landing_platform.get_node("PhysicalPad/collision")
	landing_half_width = collision_shape.shape.extents[0]
	landing_x = landing_platform.position.x
	landing_y = landing_platform.position.y
	$"../lander_labels/ROTATION".position = landing_platform.position + Vector2(-100/2,25).rotated(landing_platform.get_node("PhysicalPad/collision").rotation)
	$"../lander_labels/SPEED".position = landing_platform.position + Vector2(-100/2,50).rotated(landing_platform.get_node("PhysicalPad/collision").rotation)
	for i in range(rand_topo_point - 5, rand_topo_point+5):
		var new_y = topo_array[rand_topo_point][1]
		topo_array[i][1] = new_y
		$topo.points = topo_array
		$topo.queue_redraw()
	
func _add_next_point():
	var current_points = $topo.points
	if point_index < topo_array.size():
		var point = topo_array[point_index]
		current_points.append(point)
		point_index += 1
		$topo.points = current_points
		$topo.queue_redraw()
	else:
		$drawing_timer.stop()
		print("Topography built")
		make_landing()
		get_tree().paused = false

func _on_drawing_timer_timeout() -> void:
	_add_next_point()
	
	pass # Replace with function body.
