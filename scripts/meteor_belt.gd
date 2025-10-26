extends Node
@onready var meteor_scene = load("res://scenes/meteor.tscn")
@onready var level_root = get_parent()
@onready var timer = $"../Timer"

func _ready() -> void:
	for child in get_children():
		if is_instance_valid(level_root) and level_root.has_method("game_over"):
			child.player_hit_meteor.connect(level_root.game_over)
	
func _physics_process(delta: float) -> void:
	if get_children().size() < 8 and timer.is_stopped():
		timer.wait_time = randf_range(1,3)
		timer.start()
		print("timer started")
		

func _on_timer_timeout() -> void:
	var meteor = meteor_scene.instantiate()
	print("timer timed out")
	add_child(meteor)
	meteor.position = Vector2(-90, randf_range(0,600))
	meteor.player_hit_meteor.connect(level_root.game_over)
	timer.stop()
	pass # Replace with function body.
