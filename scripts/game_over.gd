extends Control

func _ready():
	pass


func _unhandled_input(event: InputEvent) -> void:
	if self.visible:
		if event.is_action_pressed("accept"):
			get_tree().paused = false
			get_tree().reload_current_scene()
		if event.is_action_pressed("quit"):
			get_tree().quit()
