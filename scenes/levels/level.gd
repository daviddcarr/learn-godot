extends Node2D

var laser_scene : PackedScene = preload("res://scenes/objects/projectiles/laser.tscn")
var grenade_scene : PackedScene = preload("res://scenes/objects/projectiles/grenade.tscn")


func _on_gate_player_entered_gate(_body):
	print("Player has entered gate")
	


func _on_gate_player_exited_gate(_body):
	print("Player has exited gate")


func _on_player_physics_player_fired_laser(pos, rot):
	print("laser from level")
	var laser = laser_scene.instantiate()
	
	# 1. update the laser position
	laser.position = pos
	laser.rotation = rot
	
	# 2. we have to move the laser
	# 3. Add laser instance to a Node2D
	$Projectiles.add_child(laser)
	# Can move the child's order width the following:
	# move_child(laser, 0)


func _on_player_physics_player_fired_grenade(pos, rot):
	print("grenade from level")
	var grenade = grenade_scene.instantiate() as RigidBody2D
	
	grenade.position = pos
	grenade.linear_velocity = Vector2.UP.rotated(rot) * 100
	#grenade.rotation = rot
	
	$Projectiles.add_child(grenade)
