extends StaticBody2D
signal too_fast

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	make_color()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

var root = preload("res://scenes/start.tscn").instantiate()
#var CollisionShape2D = $collision
#var ColorRect = $"collision/colored rectangle"
func make_color():
	var full_size = $collision.shape.extents * 2
	$"collision/colored rectangle".pivot_offset = full_size / 2.0
	$"collision/colored rectangle".position = -$collision.shape.extents
	$"collision/colored rectangle".size = full_size
	
