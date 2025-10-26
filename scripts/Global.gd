extends Node
var player_color : Color = Color.WHITE

func set_player_color(new_color: Color) -> void:
	player_color = new_color
	print("Player color set globally to: ", player_color)
