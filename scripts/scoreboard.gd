extends Control
var scorelist_text
# Variables
var player: String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Use an await to ensure the initial load completes before anything else tries to fetch.
	await list_scores()

# Use an async wrapper function for synchronous input checks that trigger async network calls.
func _process(delta: float) -> void:
	# Always get the player name from the TextEdit
	player = $TextEdit.text.strip_edges()
	
	# Only proceed if input is pressed AND player name is not empty
	if Input.is_action_just_pressed("accept") and not player.is_empty():
		$TextEdit.editable = false
		# Await the submission and refresh process
		await _handle_score_sequence()
		
		# Clear the text box only after the score is processed
		$TextEdit.text = ""

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
	# save_score returns a Request object. Await the signal from that object.
	var request = SilentWolf.Scores.save_score(player, Global.score)
	
	# The signal returns a dictionary containing the result.
	var result: Dictionary = await request.sw_save_score_complete
	
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
	var request = SilentWolf.Scores.get_scores(0)
	
	# The signal returns a dictionary containing the results.
	var scores_result: Dictionary = await SilentWolf.Scores.get_scores(200).sw_get_scores_complete
	# 1. Check if the scores were retrieved successfully.
	if scores_result.get("success", false) and scores_result.has("scores"):
		# The actual list of score objects is inside the 'scores' key of the result dictionary.
		var score_list: Array = scores_result.scores
		print("All scores retrieved: " + str(score_list))
		
		# 2. Iterate over the actual list of scores.
		for score_data in score_list:
			# Each item is a dictionary/object with keys like 'player_name' and 'score'
			scorelist_text = (score_data.player_name + " finished the game in " + str(int(score_data.score)) + " seconds\n")
			#binary_search_function(scorelist_text[0])
		$scorelist.text = scorelist_text
			# Your UI update logic should go here:
			# $ScoreboardUI.add_entry(score_data.player_name, score_data.score)

	else:
		print("Failed to fetch scores: ", scores_result)
