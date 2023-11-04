extends Node2D

var laser_scene : PackedScene = preload("res://scenes/objects/projectiles/laser.tscn")


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
	add_child(laser)


func _on_player_physics_player_fired_grenade():
	print("grenade from level")
