extends Node


func _ready():
	var children = get_children()
	for child in children:
		print(child)
		child.set_process_mode(PROCESS_MODE_ALWAYS)
		var timer = child.get_node("drawing_timer")
		timer.start()
		if timer.is_stopped():
			print(child," done being drawn")
		

	
