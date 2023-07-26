extends Node2D
class_name PolyCutter2D


@onready var LazerPolygon: CollisionPolygon2D = get_parent()
@onready var Lazer: Area2D = get_parent().get_parent()



const MIN_DISTANCE = 5
var prev_pos = Vector2.ZERO

func _physics_process(delta):
	if !is_visible_in_tree():
		return
	
	cut()

func cut():
	for body in Lazer.get_overlapping_bodies():
		if !body.is_in_group("lazable"):
			continue
		
#		print(body.get_node("CollisionPolygon2D").polygon)
		var results = PolygonLib.cutShape(body.get_node("CollisionPolygon2D").polygon,LazerPolygon.polygon,body.get_global_transform(), get_global_transform())
		
		if results:
			results = results.final
			if results.size() == 0:
				return
			
			
			var new_main_poly = PolygonLib.simplifyLine(results[0],Global.PolygonDetail)
			if Geometry2D.triangulate_polygon(new_main_poly).is_empty():
				print("naaah")
			body.get_node("CollisionPolygon2D").polygon = new_main_poly
#			body.get_node("CollisionPolygon2D").polygon = results[0]
#			body.position = PolygonLib.calculatePolygonCentroid(body.get_node("CollisionPolygon2D").polygon)
			if body is RigidBody2D:
				body.center_of_mass_mode = RigidBody2D.CENTER_OF_MASS_MODE_CUSTOM
				body.center_of_mass = PolygonLib.calculatePolygonCentroid(body.get_node("CollisionPolygon2D").polygon)
#			body.get_node("CollisionPolygon2D").polygon = PolygonLib.centerPolygon(body.get_node("CollisionPolygon2D").polygon)
			results.pop_front()
			#TODO: FIX THIS DAMN THING
			for result in results:
				
				if PolygonLib.getPolygonArea(result) > 100:
					var new_poly = CollisionPolygon2D.new()
					var new_rigid = RigidBody2D.new()
					var sprite = Sprite2D.new()
					sprite.texture = load("res://icon.svg")
					new_rigid.add_child(sprite)
					sprite.scale = Vector2.ONE * 0.1
					
					new_rigid.global_position = PolygonLib.calculatePolygonCentroid(result) + body.position
					new_rigid.center_of_mass_mode = RigidBody2D.CENTER_OF_MASS_MODE_CUSTOM
					new_rigid.center_of_mass = PolygonLib.calculatePolygonCentroid(result)
					new_rigid.add_to_group("lazable")
					new_poly.polygon = PolygonLib.simplifyLine(result,Global.PolygonDetail)
					new_poly.polygon = PolygonLib.translatePolygon(new_poly.polygon, - PolygonLib.calculatePolygonCentroid(result))
					new_poly.name = "CollisionPolygon2D"
					Lazer.get_parent().add_child(new_rigid)
#					new_rigid.global_position = body.global_position
					new_rigid.add_child(new_poly)

