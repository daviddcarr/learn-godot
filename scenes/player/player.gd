extends CharacterBody2D

signal player_fired_laser(pos, rot)
signal player_fired_grenade(pos, rot)

const speed = 500

var can_laser : bool = true
var can_grenade : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# Common input pattern for 2D Characters
	var direction = Input.get_vector("left", "right", "up", "down")	
	direction = direction.rotated(rotation)
	velocity = direction * speed
	move_and_slide()
	
	# Can't update position on CharacterBody2D
	#position += direction * speed * delta
	
	# laser shooting input
	if Input.is_action_just_pressed("primary action") and can_laser :
		# randomly select a marker 2D for the laser start
		var laser_markers = $LaserStartPositions.get_children()
		var random_marker = laser_markers[randi() % laser_markers.size()]

		player_fired_laser.emit(random_marker.global_position, rotation)
		can_laser = false
		$LaserTimer.start()
	
	# grenade shooting input
	if Input.is_action_just_pressed("secondary action") and can_grenade :
		
		var laser_markers = $LaserStartPositions.get_children()
		var random_marker = laser_markers[randi() % laser_markers.size()]
		
		player_fired_grenade.emit(random_marker.global_position, rotation)
		can_grenade = false
		$GrenadeTimer.start()
		
	if Input.is_action_pressed("turn clockwise") :
		rotation += 10 * delta
		
	if Input.is_action_pressed("turn anticlockwise") :
		rotation -= 10 * delta


func _on_timer_timeout():
	can_laser = true
	print("Laser Cooldown Up")


func _on_grenade_timer_timeout():
	can_grenade = true
	print("Grenade Cooldown Up")
