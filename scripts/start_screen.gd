extends Control
@onready var lander = $"../lander"
func _ready() -> void:
	lander.set_process_mode(PROCESS_MODE_DISABLED)
	$Label.add_theme_color_override("font_color",Global.player_color)
func _unhandled_input(event: InputEvent) -> void:
	if self.visible:
		if event.is_action_pressed("thrust"):
			lander.set_process_mode(PROCESS_MODE_INHERIT)
			self.visible = false
