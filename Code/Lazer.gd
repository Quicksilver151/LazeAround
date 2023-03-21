extends Node2D


func _ready():
	pass

@onready var LazerArea = $LazerArea
@onready var LazerPolygon = $LazerArea/LazerPolygon
var displacement = 0
const MIN_DISTANCE = 1
var prev_pos = Vector2.ZERO

func _unhandled_input(event):
	if event is InputEventMouse:
		position = get_global_mouse_position()
		
		displacement = (prev_pos - position).length()
		
		LazerArea.get_overlapping_areas()
		
		if displacement > MIN_DISTANCE:
			cut()
#			print("cut")
			prev_pos = position

func cut():
	for body in LazerArea.get_overlapping_bodies():
		
#		print(body.get_node("CollisionPolygon2D").polygon)
		var results = PolygonLib.cutShape(body.get_node("CollisionPolygon2D").polygon,LazerPolygon.polygon,body.get_node("CollisionPolygon2D").get_global_transform(),LazerPolygon.get_global_transform())
		
		if results:
			results = results.final
			if results.size() == 0:
				return
			
			body.get_node("CollisionPolygon2D").polygon = results[0]
			results.pop_front()
			
			for result in results:
				if PolygonLib.getPolygonArea(result) > 100:
					var new_poly = CollisionPolygon2D.new()
					var new_rigid = RigidBody2D.new()
					var sprite = Sprite2D.new()
					sprite.texture = load("res://icon.svg")
					new_rigid.add_child(sprite)
					
					new_rigid.global_position = PolygonLib.calculatePolygonCentroid(result)
					new_poly.polygon = PolygonLib.translatePolygon(result, -new_rigid.global_position)
#					new_poly.polygon = result
					new_poly.name = "CollisionPolygon2D"
					get_parent().add_child(new_rigid)
#					new_rigid.global_position = body.global_position
					new_rigid.add_child(new_poly)

