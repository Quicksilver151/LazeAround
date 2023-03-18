extends RigidBody2D

# Called when the node enters the scene tree for the first time.

var time = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time+=delta
	if time > 1:
		time = 0
		var shape1 = $CollisionPolygon2D1.polygon
		var shape2 = $CollisionPolygon2D2.polygon
		var transform1 = $CollisionPolygon2D1.get_global_transform()
		var transform2 = $CollisionPolygon2D2.get_global_transform()
		
		$CollisionPolygon2D2.position = get_global_mouse_position()
		print("Shapes: ",shape1,shape2,"\nTransforms:",transform1,transform2)
		var new_polys = PolygonLib.cutShape(shape1,shape2,transform1,transform2)
		print("output: ",new_polys)
