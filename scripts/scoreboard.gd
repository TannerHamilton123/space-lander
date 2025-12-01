extends Control
var scorelist_text = ""
# Variables
var player_name: String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_score()


func update_score():
	var score_label = $score
	score_label.text = "SCORE: " + str(snapped(Global.score,1))



# Use an async wrapper function for synchronous input checks that trigger async network calls.
func _process(delta: float) -> void:
	# Always get the player name from the TextEdit
	player_name = $TextEdit.text.strip_edges()
	
	# Only proceed if input is pressed AND player_name name is not empty
	if Input.is_action_just_pressed("accept") and not player_name.is_empty():
		
		$TextEdit.editable = false
		# Await the submission and refresh process
		await _handle_score_sequence()
		
		# Clear the text box only after the score is processed
		$TextEdit.text = ""
	if Input.is_action_just_pressed("full reset"):
		get_tree().paused = false
		var main_menu = "res://scenes/levels/main_menu.tscn"
		get_tree().change_scene_to_file(main_menu)
		Global.score = 0
	
# New function to control the async flow
func _handle_score_sequence():
	# 1. Submit the score and WAIT for it to complete.
	var submission_success: bool = await submit_score()
	
	# 2. If submission was successful, refresh the scoreboard.
	if submission_success:
		await list_scores()
		
# Must be 'async' because it uses 'await'.
# It also needs to return a status (bool) to tell the caller if it succeeded.
func submit_score() -> bool:
	var submission = SilentWolf.Scores.save_score(player_name, Global.score)
	print("here is the submission")
	print(submission)
	var result: Dictionary = await SilentWolf.Scores.get_scores().sw_get_scores_complete
	
	# Check the result dictionary for success
	if result.get("success", false):
		print("Score submitted successfully.")
		return true
	else:
		print("Failed to submit score: ", result)
		return false

# Must be 'async' because it uses 'await'.
func list_scores() -> void:
	# 0 is the default leaderboard ID. Fetching 10 scores by default.
	
	# The signal returns a dictionary containing the results.
	var scores_result: Dictionary = await SilentWolf.Scores.get_scores().sw_get_scores_complete
	# 1. Check if the scores were retrieved successfully.
	if scores_result.get("success", false) and scores_result.has("scores"):
		# The actual list of score objects is inside the 'scores' key of the result dictionary.
		
		# 2. Iterate over the actual list of scores.
		for score_data in scores_result.scores:
			var s_timestamp: float = score_data.timestamp / 1000
			#var date = get_date_string_from_unix_time(s_timestamp)
			var date = Time.get_date_string_from_unix_time(s_timestamp)

			
			scorelist_text += (str(score_data.player_name) + " finished the game in " + str(int(score_data.score)) + " seconds on " + date + "\n") #3+ score_data.date + 
			#binary_search_function(scorelist_text[0])
		$scorelist.text = scorelist_text
			# Your UI update logic should go here:
			# $ScoreboardUI.add_entry(score_data.player_name, score_data.score)

	else:
		print("Failed to fetch scores: ", scores_result)
