
extends Area2D

@onready var topo_array = $Polygon2D.get_polygon()
@onready var asteroid_shape = get_parent()
var point_index := 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	
	$CollisionPolygon2D.set_polygon($Polygon2D.get_polygon())
	$CollisionPolygon2D.position = $Polygon2D.position
	$Line2D.position - $Polygon2D.position
	#$Polygon2D.set_polygon([])
	topo_array.append(topo_array[0])
	$Polygon2D.visible = false
	$Polygon2D.color = Color.BLACK

func _add_next_point():
	var current_points = $Line2D.points
	if point_index < topo_array.size():
		var point = topo_array[point_index]
		current_points.append(point)
		point_index += 1
		#$Polygon2D.set_polygon(current_points)
		$Line2D.points = current_points
		$Line2D.queue_redraw()
	
		
	else:
		
		$drawing_timer.stop()
		print("Topography built")
		$Polygon2D.visible = true
	
func _process(delta: float) -> void: 
	
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		
		owner.game_over()                 
	pass # Replace with function body.


func _on_drawing_timer_timeout() -> void:
	_add_next_point()
	pass # Replace with function body.
