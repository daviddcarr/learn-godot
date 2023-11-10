extends CharacterBody2D

var waypoints = []
var currentTarget = 0

var vulnerable: bool = true

var active: bool = false
var exploding: bool = false

var speed = 100.0
var explosion_radius = 200


@export var HEALTH = 20
var currentHealth = HEALTH

func _ready():	
	$Sprite2D.show()
	$Explosion.hide()
	var wps = $waypoints.get_children()
	for wp in wps :
		waypoints.append(wp.global_position)
		
	var direction = (waypoints[0] - waypoints[1]).normalized()
	rotation = direction.angle()

	
func _physics_process(delta):
	var direction: Vector2 = Vector2(0,0)
	var nextTarget = currentTarget
	if not exploding:
		if active :
			look_at(Globals.player_pos)
			direction = (Globals.player_pos - global_position).normalized()
		else :	
			if (global_position.distance_to(waypoints[currentTarget]) < 100) :
				nextTarget = (currentTarget + 1) % waypoints.size()
			direction = (waypoints[nextTarget] - global_position).normalized()
	
		rotation = direction.angle()
		currentTarget = nextTarget
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO
	
	var collision = move_and_collide(velocity * delta)
	if collision:
		exploding = true
		$AnimationPlayer.play("explosion")

func hit(amount) :
	if vulnerable:
		currentHealth -= amount
		$AudioStreamPlayer2D.play()
		vulnerable = false
		$HitTimer.start()
		var hit_tween = create_tween()
		hit_tween.tween_method(set_shader_values, 1.0, 0.0, $HitTimer.wait_time).set_trans(Tween.TRANS_ELASTIC)
		await hit_tween.finished
		if currentHealth <= 0 :
			exploding = true
			$AnimationPlayer.play("explosion")
			
func explode():
	$ExplosionAudio.play()
	var targets = get_tree().get_nodes_in_group('Container') + get_tree().get_nodes_in_group('Entity') 
	for target in targets :
		print(target)
		var distance = global_position.distance_to(target.global_position)
		if "hit" in target and distance < explosion_radius :
			target.hit(10)

func _on_notice_area_body_entered(body):
	active = true
	var speed_tween = create_tween()
	speed_tween.tween_property(self, "speed", 400.0, 5)

func set_shader_values(value) : 
	$Sprite2D.material.set_shader_parameter("progress", value)

func _on_hit_timer_timeout():
	vulnerable = true

