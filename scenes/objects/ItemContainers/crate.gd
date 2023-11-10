extends ItemContainer

func hit(_amount) :
	if not opened:
		$AudioStreamPlayer2D.play()
		$LidSprite.hide()
		for i in range(5) :
			var pos = $SpawnPositions.get_children().pick_random().global_position
			open.emit(pos, current_direction)
		opened = true
	
