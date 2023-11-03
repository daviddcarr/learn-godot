extends Node2D

const speed = 500
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var direction = Input.get_vector("left", "right", "up", "down")
	
	position += direction * speed * delta
	
	# laser shooting input
	if Input.is_action_just_pressed("primary action") :
		print("Pew pew!")
		
	# secondary input (Shield or something)
	#	if Input.is_action_just_pressed("secondary action") :
	#		print("Shield Going Up!")
	#
	#	if Input.is_action_pressed("secondary action") :
	#		print("Shield online.")
	#
	#	if Input.is_action_just_released("secondary action") :
	#		print("Shield down...")
	
	if Input.is_action_just_pressed("secondary action") :
		print("Launch Grenade")
