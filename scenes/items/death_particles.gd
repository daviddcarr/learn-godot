extends GPUParticles2D

var color : Color = Color("#3333ff")

func _ready():
	modulate = color
	restart()
	$Timer.start()

func _on_timer_timeout():
	queue_free()
