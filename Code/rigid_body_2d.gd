extends RigidBody2D

# Called when the node enters the scene tree for the first time.

var time = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
var polygons : PackedVector2Array
func _process(delta):
	time+=delta
	if time > 0.1:
		time = 0
		var shape1 = $CollisionPolygon2D1.polygon
		var shape2 = $CollisionPolygon2D2.polygon
		var transform1 = $CollisionPolygon2D1.get_global_transform()
		var transform2: Transform2D = $CollisionPolygon2D2.get_global_transform()
		
		$CollisionPolygon2D2.position = get_global_mouse_position()
#		print("Shapes: ",shape1,shape2,"\nTransforms:",transform1,transform2)
		var new_polys = PolygonLib.cutShape(shape1,shape2,transform1,transform2)
#		print("output: ",new_polys)
		var poly = new_polys.final
		if poly:
			var polygon: PackedVector2Array = poly[0]
			Global.draw_shape(PolygonLib.translatePolygon(polygon,transform2.origin))
		else:
			return


#func _draw():
#	if polygons:
#		for poly in polygons:
#			var prev_point = poly[0]
#			for i in range(poly.-1):
#
#				draw_line(poly[i+1],prev_point,Color.NAVY_BLUE,3)
#
#				prev_point = poly[i+1]
#			draw_line(poly[0],prev_point,Color.NAVY_BLUE,3)
