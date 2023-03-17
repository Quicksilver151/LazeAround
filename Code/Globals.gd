extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _unhandled_key_input(event):
	if event.is_action_pressed("f_fullscreen"):
		toggle_fullscreen()



func toggle_fullscreen():
	match DisplayServer.window_get_mode():
		3 : DisplayServer.window_set_mode(0)
		0 : DisplayServer.window_set_mode(3)

