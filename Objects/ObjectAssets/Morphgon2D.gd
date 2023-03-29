extends CollisionPolygon2D
class_name Morphgon2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var new_polygon = PolygonLib.createRectanglePolygon(Vector2(5,5))
	polygon = new_polygon

var time : float = 0.0
var LAPSE: float = 0.1
func _physics_process(delta):
	# for each second:
	time += delta
	if time > LAPSE:
		change_shape()
		time = 0.0
	

func change_shape():
	
	print("okk")
	
	
