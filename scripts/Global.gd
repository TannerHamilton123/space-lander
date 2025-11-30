extends Node
var player_color : Color = Color.WHITE
var score = 0
func set_player_color(new_color: Color) -> void:
	player_color = new_color
	print("Player color set globally to: ", player_color)

func _ready():
	var background_music  = AudioStreamPlayer.new()
	add_child(background_music)
	background_music.set_physics_process(PROCESS_MODE_ALWAYS)
	background_music.stream = load("res://assets/perfect-beauty-191271.mp3") 
	print(background_music.stream)
	background_music.play()
	
	SilentWolf.configure({
	"api_key": "bRIszXPRBdOvk0jN3SFO3QZjWZDY8OAaOZvq3oK7",
	"game_id": "SpaceLander",
	"log_level": 1
	})

	SilentWolf.configure_scores({
	"open_scene_on_close": "res://scenes/MainPage.tscn"
	})
func start_music():
	pass
