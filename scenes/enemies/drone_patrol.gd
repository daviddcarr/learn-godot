extends CharacterBody2D

var waypoints = []
var currentTarget = 0

const SPEED = 100.0
var speed = Vector2(SPEED, SPEED)


@export var HEALTH = 20
var currentHealth = HEALTH

func _ready():	
	var wps = $waypoints.get_children()
	for wp in wps :
		waypoints.append(wp.global_position)
		
	var direction = (waypoints[0] - waypoints[1]).normalized()
	rotation = direction.angle()
	speed = direction * SPEED
	
func _physics_process(_delta):
	
	if (global_position.distance_to(waypoints[currentTarget]) < 100) :
		var nextTarget = (currentTarget + 1) % waypoints.size()
		var direction = (waypoints[nextTarget] - waypoints[currentTarget]).normalized()
		rotation = direction.angle()
		currentTarget = nextTarget
		speed = direction * SPEED
		
	velocity = speed
	move_and_slide()
	

func hit(amount) :
	currentHealth -= amount
	if currentHealth <= 0 :
		print("Drone destroyed")
		queue_free()




