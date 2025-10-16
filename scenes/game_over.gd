extends Control

func _ready():
	
	if self.visible:
		print("game over")
	if Input.is_action_just_pressed("accept"):
		get_tree().paused = false
		get_tree().reload_current_scene()


func _unhandled_input(event: InputEvent) -> void:
	if self.visible:
		if event.is_action_pressed("accept"):
			get_tree().paused = false
			get_tree().reload_current_scene()
