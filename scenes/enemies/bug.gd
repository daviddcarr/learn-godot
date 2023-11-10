extends CharacterBody2D

var player_nearby : bool = false
var player_in_range : bool = false
var is_biting : bool = false
var target 

var vulnerable : bool = true

var speed : int = 300
var health : int = 30

func _process(_delta) :
	if player_nearby and not is_biting :
		look_at(Globals.player_pos)
		var direction = (Globals.player_pos - global_position).normalized()
		velocity = direction * speed
		move_and_slide()

			
func set_shader_values(value) : 
	$AnimatedSprite2D.material.set_shader_parameter("progress", value)

func hit(amount) :
	if vulnerable :
		health -= amount
		$AudioStreamPlayer2D.play()
		vulnerable = false
		$Timers/HitTimer.start()
		var hit_tween = create_tween()
		hit_tween.tween_method(set_shader_values, 1.0, 0.0, $Timers/HitTimer.wait_time).set_trans(Tween.TRANS_ELASTIC)
		$Particles/HitParticles.restart()
		await hit_tween.finished
		if health <= 0 :
			# $ParticleAnimation.emitting = true
			# await get_tree().create_timer(0.5).timeout
			queue_free()
			

# Start Attacking Player
func _on_attack_area_body_entered(body):
	player_in_range = true
	is_biting = true
	target = body
	$AnimatedSprite2D.play("attack")

# Stop Attacking Player
func _on_attack_area_body_exited(_body):
	player_in_range = false


# Start Following Player
func _on_notice_area_body_entered(_body):
	player_nearby = true
	$AnimatedSprite2D.play("walk")

# Stop Following Player
func _on_notice_area_body_exited(_body):
	player_nearby = false
	$AnimatedSprite2D.stop()


func _on_bite_timer_timeout():
	if player_in_range:
		$AnimatedSprite2D.play("attack")



func _on_hit_timer_timeout():
	vulnerable = true


func _on_animated_sprite_2d_animation_finished():
	is_biting = false
	if player_in_range:
		target.hit(5)
		$Timers/BiteTimer.start()
