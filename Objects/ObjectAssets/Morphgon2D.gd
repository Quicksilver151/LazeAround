extends CollisionPolygon2D
class_name Morphgon2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var new_polygon = PolygonLib.createRectanglePolygon(Vector2(1,1)*10)
	polygon = new_polygon

var time : float = 0.0
var LAPSE: float = 0.01
func _physics_process(delta):
	# for each second:
	time += delta
	if time > LAPSE:
		change_shape()
		time = 0.0
	

func change_shape():
	var points = get_node("Line2D").points
	
	var new_polygon = PolygonLib.createRectanglePolygon(Vector2(1,1)*10)
	var new_node = Polygon2D.new()
	new_node.polygon = new_polygon
	new_node.self_modulate.a = 0.3
	new_node.position = global_position
	get_parent().get_parent().add_child(new_node)
	
	print("okk")
	
	
