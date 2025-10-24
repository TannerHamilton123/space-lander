extends CPUParticles2D

var time_thrusting := 0.0
var max_dB := 0.0
var min_dB = -20.0
var time_to_max := 3.0
var progress : float
var dB : float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$thrust_sound.stop()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if emitting and not $thrust_sound.playing:
			$thrust_sound.play()
			
	if not emitting:
		time_thrusting = 0
		$thrust_sound.stop()
		
	if $thrust_sound.playing:
		time_thrusting += delta
		progress = time_thrusting / time_to_max
		
		dB = lerp(min_dB,max_dB,progress)
		$thrust_sound.volume_db = dB
	pass
