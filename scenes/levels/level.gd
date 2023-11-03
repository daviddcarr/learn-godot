extends Node2D

var test_array: Array[String] = ["Test", "Hello", "World"]


# Called when the node enters the scene tree for the first time.
func _ready():
	#get_node("Logo").rotation_degrees = 90
	$Logo.rotation_degrees = 90
	
	for i in test_array:
		print(i)
		
	# Access as Unique Name % does this:
	# %Target = $Sprite2D/Sprite2D2/Sprite2D3/Target
	
func _process(delta):
	$Logo.rotation_degrees += 10 * delta

	if $Logo.rotation_degrees > 180 :
		$Logo.rotation_degrees = 0

	#if Input.is_action_pressed("left") :
	#	$Logo.scale += Vector2(0.25, 0.25)


func test_function() :
	print("This is a test function")
