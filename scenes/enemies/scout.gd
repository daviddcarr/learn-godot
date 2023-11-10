extends CharacterBody2D

var player_nearby : bool = false
var can_laser : bool = true
var right_gun_use : bool = true
var vulnerable : bool = true

var health : int = 30

signal laser(pos, direction)

func _process(_delta) :
	if player_nearby :
		look_at(Globals.player_pos)
		if can_laser :
			#var pos: Vector2 = $LaserSpawnPositions.get_children().pick_random().global_position
			var pos : Vector2 = $LaserSpawnPositions.get_child(right_gun_use).global_position
			right_gun_use = not right_gun_use
			laser.emit(pos, rotation)
			can_laser = false
			$Timers/LaserTimer.start()


func _on_attack_area_body_entered(_body):
	player_nearby = true


func _on_attack_area_body_exited(_body):
	player_nearby = false

	
func hit(amount) :
	if vulnerable :
		health -= amount
		$AudioStreamPlayer2D.play()
		vulnerable = false
		$Timers/HitTimer.start()
		var hit_tween = create_tween()
		hit_tween.tween_method(set_shader_values, 1.0, 0.0, $Timers/HitTimer.wait_time).set_trans(Tween.TRANS_ELASTIC)
		await hit_tween.finished
		if health <= 0 :
			queue_free()
		#tween.tween_property(self, "position", target_pos, 0.5).set_trans(Tween.TRANS_CIRC)
		#$Sprite2D.material.set_shader_parameter("progress", 1)
	else :
		print("Invulnerable")

func set_shader_values(value) : 
	$Sprite2D.material.set_shader_parameter("progress", value)

func _on_laser_timer_timeout():
	can_laser = true


func _on_hit_timer_timeout():
	vulnerable = true
	$Sprite2D.material.set_shader_parameter("progress", 0)
