extends Area2D

var rotation_speed: int = 5
var type = ['laser', 'laser', 'laser', 'laser', 'grenade', 'health'].pick_random()
# var available_options = ['laser', 'grenade', 'health']
# var type = available_options[randi()%len(available_options)]
var color : Color = Color("#3333ff")

signal item_destroyed(pos, color)

var direction : Vector2
var distance : int = randi_range(150, 250)

func _ready() :
	# type = 'health'
	if type == 'laser' :
		color = Color("#3333ff")
	if type == 'grenade' :
		color = Color("#ff3333")
	if type == 'health' :
		color = Color("#33ff33")
		
	$Sprite2D.modulate = color
	$GPUParticles2D.modulate = color
		
	#tween
	var target_pos = position + (direction * distance)
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "position", target_pos, 0.5).set_trans(Tween.TRANS_CIRC)
	tween.tween_property(self, "scale", Vector2(1,1), 0.5).from(Vector2.ZERO).set_trans(Tween.TRANS_CIRC)

func _process(delta) :
	rotation += rotation_speed * delta


func _on_body_entered(_body):
	item_destroyed.emit(position, color)
	if (type == 'health') :
		Globals.health += 10
	if type == 'laser' :
		Globals.laser_amount += 5
	if type == 'grenade' :
		Globals.grenade_amount += 3
	queue_free()
