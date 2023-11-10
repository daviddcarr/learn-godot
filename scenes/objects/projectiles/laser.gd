extends Area2D

@export var speed = 1000
var speedDirection : Vector2 = Vector2.RIGHT * speed

var pos : Vector2 = Vector2.ZERO
var rot : float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pos = position
	rot = rotation
	$Timer.start()
	$AudioStreamPlayer2D.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pos += speedDirection.rotated(rotation) * delta
	
	position = pos


func _on_body_entered(body):
	#if body.has_method("hit") :
	if "hit" in body :
		body.hit(10)
	queue_free()

func _on_timer_timeout():
	print("laser self destructed")
	queue_free()
