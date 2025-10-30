extends Node
var player_color : Color = Color.WHITE

func set_player_color(new_color: Color) -> void:
	player_color = new_color
	print("Player color set globally to: ", player_color)

func start_music():
	pass
	
	
func _ready() -> void:
	var background_music  = AudioStreamPlayer.new()
	add_child(background_music)
	background_music.set_physics_process(PROCESS_MODE_ALWAYS)
	background_music.stream = load("res://assets/perfect-beauty-191271.mp3") 
	print(background_music.stream)
	background_music.play()
