extends Node

@onready var children = get_children()
func _ready():
	$"../landing_platform".visible = false
	$"../lander_labels".visible = false
	var i := 0
	_draw_obstacle(i)
	pass

func _draw_obstacle(i):
	if i < children.size():
		
		var child = children[i]
		print(i,child)
		child.get_node("drawing_timer").start()
		child.set_process_mode(PROCESS_MODE_ALWAYS)
		#starts the timer of the individual obstacle
		#sets the process to always so that it draws now
		
		var next_call = Callable(self,"_draw_obstacle")
		var bound_call = next_call.bind(i+1)
		#create a callable and bind it to the argument of i (next obstacle)
		child.connect("done_drawing",bound_call)
		#once the obstacle sends the signal that it is done drawing, i call the bound callable and do the 
		#function for the next obstacle!
	else:
		print("done")
		$"../landing_platform".visible = true
		$"../lander_labels".visible = true
	
