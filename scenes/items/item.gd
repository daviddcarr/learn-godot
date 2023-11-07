extends Area2D

var rotation_speed: int = 5
var type = ['laser', 'laser', 'laser', 'laser', 'grenade', 'health'].pick_random()
# var available_options = ['laser', 'grenade', 'health']
# var type = available_options[randi()%len(available_options)]

func _ready() :
	# type = 'health'
	if type == 'laser' :
		$Sprite2D.modulate = Color("#3333ff")
	if type == 'grenade' :
		$Sprite2D.modulate = Color("#ff3333")
	if type == 'health' :
		$Sprite2D.modulate = Color("#33ff33")

func _process(delta) :
	rotation += rotation_speed * delta


func _on_body_entered(body):
	if (type == 'health') :
		Globals.health += 10
	else :
		body.add_item(type)
	queue_free()
