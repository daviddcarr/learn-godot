extends CharacterBody2D


const SPEED = 100.0
var speed = Vector2(SPEED, SPEED)

var windowSize = Vector2(0,0)
var spriteSize = Vector2(0,0)

var currentPosition = Vector2(0,0)

func _ready():
	windowSize = get_window().size
	spriteSize = Vector2( $Sprite2D.texture.get_width() * $Sprite2D.scale.x, $Sprite2D.texture.get_height() * $Sprite2D.scale.y )

	currentPosition = position
	
	updateFramesSinceBounce()
	
func _physics_process(delta):
	windowSize = get_window().size
	
		# Sprite  Diameter
	var dy = spriteSize.y / 2
	var dx = spriteSize.x / 2
	
	# Sprite's extremity positions relative to canvas.
	var topPos = currentPosition.y - dy
	var rightPos = currentPosition.x + dx
	var bottomPos = currentPosition.y + dy
	var leftPos = currentPosition.x - dx
	
		# Set states for detecting bounce
	var topBounced = false
	var rightBounced = false
	var bottomBounced = false
	var leftBounced = false
	
		# detect bounces
	if ( topPos <= 0 ) :
		speed = Vector2(speed.x, -1 * speed.y)
		topBounced = true
		updateFramesSinceBounce()
		
	if ( rightPos >= windowSize.x ) :
		speed = Vector2(-1 * speed.x, speed.y)
		rightBounced = true
		updateFramesSinceBounce()
		
	if ( bottomPos >= windowSize.y ) :
		speed = Vector2(speed.x, -1 * speed.y)
		bottomBounced = true
		updateFramesSinceBounce()
	
	if ( leftPos <= 0 ) :
		speed = Vector2(-1 * speed.x, speed.y)
		leftBounced = true
		updateFramesSinceBounce()
		
	velocity = speed
	move_and_slide()
	
	currentPosition = position
	
func updateFramesSinceBounce() :
	print("Bounced")
	
	if ( speed.x > 0 && speed.y > 0 ) :
		rotation_degrees = 135
	if ( speed.x > 0 && speed.y < 0 ) :
		rotation_degrees = 45
	if ( speed.x < 0 && speed.y > 0 ) :
		rotation_degrees = 215
	if ( speed.x < 0 && speed.y < 0 ) :
		rotation_degrees = -45

	




