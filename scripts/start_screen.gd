extends Control

func _ready() -> void:
	get_tree().paused = true
	$Label.add_theme_color_override("font_color",Global.player_color)
func _unhandled_input(event: InputEvent) -> void:
	if self.visible:
		if event.is_action_pressed("thrust"):
			get_tree().paused = false
			self.visible = false
