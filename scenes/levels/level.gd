extends Node2D
class_name LevelParent

var laser_scene : PackedScene = preload("res://scenes/objects/projectiles/laser.tscn")
var grenade_scene : PackedScene = preload("res://scenes/objects/projectiles/grenade.tscn")
var item_scene : PackedScene = preload("res://scenes/items/item.tscn")
var death_particles_scene : PackedScene = preload("res://scenes/items/death_particles.tscn")

func _ready() :
	
	for container in get_tree().get_nodes_in_group('Container') :
		print(container)
		container.connect("open", _on_container_open)
	for scout in get_tree().get_nodes_in_group("Scouts") :
		scout.connect("laser", _on_scout_laser)

func _on_container_open(pos, direction) :
	var item = item_scene.instantiate()
	item.position = pos
	item.direction = direction
	item.connect("item_destroyed", _on_item_destroyed)
	
	$Items.call_deferred("add_child", item)

func _on_item_destroyed(pos, color) :
	print("Item Destroyed")
	var death_particles = death_particles_scene.instantiate()
	death_particles.position = pos
	death_particles.color = color
	$Items.add_child(death_particles)

func _on_scout_laser(pos, rot) :
	create_laser(pos, rot)
	
func _on_player_physics_player_fired_laser(pos, rot):
	create_laser(pos, rot)

func create_laser(pos, rot) : 
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
	var grenade = grenade_scene.instantiate() as RigidBody2D
	
	grenade.position = pos
	grenade.linear_velocity = Vector2.RIGHT.rotated(rot) * grenade.speed
	#grenade.rotation = rot
	
	$Projectiles.add_child(grenade)

