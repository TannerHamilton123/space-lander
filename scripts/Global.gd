extends Node
var player_color : Color = Color.WHITE

func set_player_color(new_color: Color) -> void:
	player_color = new_color
	print("Player color set globally to: ", player_color)

func _ready():
	SilentWolf.configure({
	"api_key": "bRIszXPRBdOvk0jN3SFO3QZjWZDY8OAaOZvq3oK7",
	"game_id": "SpaceLander",
	"log_level": 1
	})

	SilentWolf.configure_scores({
	"open_scene_on_close": "res://scenes/MainPage.tscn"
	})
