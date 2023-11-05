extends Area2D

@export var speed = 1000
var speedDirection : Vector2 = Vector2.UP * speed

var pos : Vector2 = Vector2.ZERO
var rot : float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pos = position
	rot = rotation


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pos += speedDirection.rotated(rotation) * delta
	
	position = pos
