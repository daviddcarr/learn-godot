extends CharacterBody2D

signal player_fired_laser(pos, rot)
signal player_fired_grenade(pos, rot)

@export var max_speed: int = 500

var speed: int = max_speed

var can_laser : bool = true
var can_grenade : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	# Common input pattern for 2D Characters
	var direction = Input.get_vector("left", "right", "up", "down")	
	# direction = direction.rotated(rotation)
	velocity = direction * speed
	move_and_slide()
	Globals.player_pos = global_position
	
	# rotate, cursor based rotation
	look_at(get_global_mouse_position())
	
	# Can't update position on CharacterBody2D
	#position += direction * speed * delta
	
	# laser shooting input
	if Input.is_action_just_pressed("primary action") and can_laser and Globals.laser_amount > 0 :
		Globals.laser_amount -= 1
		
		# randomly select a marker 2D for the laser start
		var laser_markers = $LaserStartPositions.get_children()
		var random_marker = laser_markers[randi() % laser_markers.size()]
		
		$Gunfire.restart()
		$Gunfire/Sparks.restart()
		
		player_fired_laser.emit(random_marker.global_position, rotation)
		can_laser = false
		$LaserTimer.start()
	
	# grenade shooting input
	if Input.is_action_just_pressed("secondary action") and can_grenade and Globals.grenade_amount > 0 :
		
		Globals.grenade_amount -= 1
		
		var laser_markers = $LaserStartPositions.get_children()
		var random_marker = laser_markers[randi() % laser_markers.size()]
		
		player_fired_grenade.emit(random_marker.global_position, rotation)
		can_grenade = false
		$GrenadeTimer.start()
	
	# This was my original implementation of turning, tutorial is going another way	
	#	if Input.is_action_pressed("turn clockwise") :
	#		rotation += 10 * delta
	#
	#	if Input.is_action_pressed("turn anticlockwise") :
	#		rotation -= 10 * delta


func _on_timer_timeout():
	can_laser = true
	print("Laser Cooldown Up")


func _on_grenade_timer_timeout():
	can_grenade = true
	print("Grenade Cooldown Up")
	
	
#func add_item(type: String) -> void :
#	if type == 'laser' :
#		Globals.laser_amount += 5
#	if type == 'grenade' :
#		Globals.grenade_amount += 3
#	if type == 'health' :
#		print("Increase Health")
#	update_stats.emit()
	
func hit(amount) :
	Globals.health -= amount
