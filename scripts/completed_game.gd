extends Control

func _unhandled_input(event: InputEvent) -> void:
	var current_scene_file = get_tree().current_scene.scene_file_path
	var next_level_number = current_scene_file.to_int() + 1
	var next_level_path = "res://scenes/levels/level" + str(next_level_number)+".tscn"
	var main_menu = "res://scenes/levels/main_menu.tscn"
	if self.visible:
		if event.is_action_pressed("accept"):
			if next_level_number  == 6:
				get_tree().change_scene_to_file(main_menu)
				get_tree().paused = false
			get_tree().change_scene_to_file(next_level_path)
				get_tree().paused = false
			#get_tree().reload_current_scene()
	
	
