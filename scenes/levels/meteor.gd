extends Area2D
@onready var speed := randf_range(.2,5)
@onready var velocity = Vector2(speed,0)
func _ready() -> void:
	$CollisionPolygon2D.set_polygon($Line2D.points)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		owner.game_over()
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	position += velocity
	rotation_degrees += .1
	print(position)
	
	if  -100 > position.x or position.x > 1300 or -100 > position.y or position.y > 900:
		var rand_y = randi_range(200,600)
		var speed := randf_range(.2,5)
		position = Vector2(0, rand_y)
	

	
