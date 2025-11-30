extends Control
var player_name
var score

func _ready() -> void:
	if Input.is_action_just_pressed("accept") and player_name:
		submit_score()

func submit_score():
	SilentWolf.Scores.persist_score(player_name, score)
