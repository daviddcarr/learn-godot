extends LevelParent

@export var inside_level_scene : PackedScene

func _on_gate_player_entered_gate(_body):
	print("Player has entered gate")
	var tween = create_tween()
	tween.tween_property($player, "speed", 0, 0.5)
	TransitionLayer.change_scene("res://scenes/levels/inside.tscn")


func _on_house_player_entered():
	print("player has entered house in level")
	var tween = get_tree().create_tween()
	# tween.set_parallel(true) # makes animations play together instead of sequentially
	# tween.set_loops(true) # loopy
	tween.tween_property($player/Camera2D, "zoom", Vector2(1,1), 1)
	# ().from(start_value)
	# ().set_trans(Tween.TRANS_TYPE) # easing
	# tween.tween_property($player, "modulate:a", 0, 2)

func _on_house_player_left():
	var tween = get_tree().create_tween()
	tween.tween_property($player/Camera2D, "zoom", Vector2(0.6,0.6), 1)
