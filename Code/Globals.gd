extends Node

var PolygonDetail: int = 5

# Called when the node enters the scene tree for the first time.
var line: Line2D = Line2D.new()

func _ready():
	add_child(line)
	line.width = 5
	line.joint_mode = Line2D.LINE_JOINT_ROUND

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _unhandled_key_input(event):
	if event.is_action_pressed("f_fullscreen"):
		toggle_fullscreen()



func draw_shape(polygon:PackedVector2Array):
	line.clear_points()
	for point in polygon:
#		print(polygon)
		line.add_point(point)
	line.add_point(polygon[0])
	


func toggle_fullscreen():
	match DisplayServer.window_get_mode():
		3 : DisplayServer.window_set_mode(0)
		0 : DisplayServer.window_set_mode(3)

