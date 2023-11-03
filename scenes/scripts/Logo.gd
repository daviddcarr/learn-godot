extends Sprite2D

var pos: Vector2 = Vector2.ZERO
var speed: Vector2 = Vector2(5, 5)

var rot: float = 0.0
const rotationSpeed: float = 0.5

var windowSize = Vector2(0,0)
var spriteSize = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	windowSize = get_window().size
	spriteSize = Vector2( texture.get_width(), texture.get_height() )
	pos = Vector2(windowSize.x / 2, windowSize.y / 2)

	position = pos
	rotation_degrees = rot
	

	print(spriteSize)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	windowSize = get_window().size
	
	var dy = spriteSize.y / 2
	var dx = spriteSize.x / 2
	var topPos = pos.y - dy
	var rightPos = pos.x + dx
	var bottomPos = pos.y + dy
	var leftPos = pos.x - dx
	
	if ( topPos <= 0 ) :
		speed = Vector2(speed.x, -1 * speed.y)
		
	if ( rightPos >= windowSize.x ) :
		speed = Vector2(-1 * speed.x, speed.y)
		
	if ( bottomPos >= windowSize.y ) :
		speed = Vector2(speed.x, -1 * speed.y)
	
	if ( leftPos <= 0 ) :
		speed = Vector2(-1 * speed.x, speed.y)
		
	pos += speed
	position = pos
	
	rot += rotationSpeed
	rotation_degrees = rot
	
	
	
