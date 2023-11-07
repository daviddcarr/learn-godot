extends Node2D
class_name LevelParent

var laser_scene : PackedScene = preload("res://scenes/objects/projectiles/laser.tscn")
var grenade_scene : PackedScene = preload("res://scenes/objects/projectiles/grenade.tscn")


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
	$UI.update_laser_text()


func _on_player_physics_player_fired_grenade(pos, rot):
	print("grenade from level")
	var grenade = grenade_scene.instantiate() as RigidBody2D
	
	grenade.position = pos
	grenade.linear_velocity = Vector2.RIGHT.rotated(rot) * grenade.speed
	#grenade.rotation = rot
	
	$Projectiles.add_child(grenade)
	
	$UI.update_grenade_text()


func _on_house_player_entered():
	print("player has entered house in level")
	var tween = get_tree().create_tween()
	# tween.set_parallel(true) # makes animations play together instead of sequentially
	# tween.set_loops(true) # loopy
	tween.tween_property($player/Camera2D, "zoom", Vector2(1,1), 1)
	# ().from(start_value)
	# ().set_trans(Tween.TRANS_TYPE) # easing
	# tween.tween_property($player, "modulate:a", 0, 2)

func _on_house_player_left():
	var tween = get_tree().create_tween()
	tween.tween_property($player/Camera2D, "zoom", Vector2(0.6,0.6), 1)


func _on_player_update_stats():
	$UI.update_laser_text()
	$UI.update_grenade_text()
