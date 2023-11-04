extends Sprite2D

var pos: Vector2 = Vector2.ZERO
var speed: Vector2 = Vector2(200, 200)

var rot: float = 0.0
var rotationSpeed: float = 0.5

var windowSize = Vector2(0,0)
var spriteSize = Vector2(0,0)

# How many frames count as a double bounce to reverse sprite direction
var doubleBounceSensitivity = 10
var framesSinceBounce = doubleBounceSensitivity + 1

# Called when the node enters the scene tree for the first time.
func _ready():
	# get initial sizes and set initial position
	windowSize = get_window().size
	spriteSize = Vector2( texture.get_width(), texture.get_height() )
	pos = Vector2(windowSize.x / 2, windowSize.y / 2)

	position = pos
	#rotation_degrees = rot
	
	# Get Parent Node
	print($"..".test_array)
	$"..".test_function()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	windowSize = get_window().size
	
	# Sprite  Diameter
	var dy = spriteSize.y / 2
	var dx = spriteSize.x / 2
	
	# Sprite's extremity positions relative to canvas.
	var topPos = pos.y - dy
	var rightPos = pos.x + dx
	var bottomPos = pos.y + dy
	var leftPos = pos.x - dx
	
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
		
		
	# set position and rotation
	pos += speed * delta
	position = pos
	
	rot += rotationSpeed
	#rotation_degrees = rot
	
	#continue frame count for bounce direction / updateFrameSinceBounce()
	framesSinceBounce += 1
	
# function to check if bounces happen within 10 frames, and to reset frames on bounce
func updateFramesSinceBounce() :
	if (framesSinceBounce < doubleBounceSensitivity) :
		rotationSpeed = rotationSpeed * -1.05
	framesSinceBounce = 0
	
	
	
