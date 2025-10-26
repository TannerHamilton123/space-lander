extends Area2D
@onready var speed := randf_range(.5,1.5)
@onready var velocity = Vector2(speed,0)
signal player_hit_meteor

func _ready() -> void:
	$CollisionPolygon2D.set_polygon($Line2D.points)
	$Polygon2D.set_polygon($Line2D.points)
	$Polygon2D.color = Color.BLACK
	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("you hit a meteor!")
		player_hit_meteor.emit()

func _physics_process(delta: float) -> void:
	position += velocity
	rotation_degrees += .1
	
	if  (position.x > 1300 
		or position.y < -100
		or position.y > 900):
		queue_free()
	

	
