extends Area2D

signal too_fast
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("COLLISION AREA")
		var speed = body.velocity.length()
		if speed > 20 or body.rotation_degrees > abs(45):
			print("bad landing",speed,body.rotation_degrees)
			emit_signal("too_fast")
		else:
			print("good landing",speed,body.rotation_degrees)
			await get_tree().create_timer(2.0).timeout
			get_tree().reload_current_scene()
