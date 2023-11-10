extends RigidBody2D

const speed = 750
var explosion_radius = 200

func explode() :
	$AnimationPlayer.play("Explosion")
	set_freeze_enabled(true)
	var targets = get_tree().get_nodes_in_group('Container') + get_tree().get_nodes_in_group('Entity') 
	for target in targets :
		var distance = global_position.distance_to(target.global_position)
		if "hit" in target and distance < explosion_radius :
			target.hit(10)
	
