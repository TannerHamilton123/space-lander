extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set("gravity_point_center",$"CollisionShape2D".position)
	print(gravity_point_center)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
