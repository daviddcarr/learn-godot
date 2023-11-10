extends Node

#signal laser_change
#signal grenade_change
#signal health_change

signal stat_change

var player_hit_sound: AudioStreamPlayer2D

var laser_amount = 20 :
#	get:
#		return laser_amount
	set(value):
		laser_amount = value
		stat_change.emit()

var grenade_amount = 10 :
	get:
		return grenade_amount
	set(value):
		grenade_amount = value
		stat_change.emit()


var player_vulnerable : bool = true

var max_health : int = 100
var health = 60 : 
	get: 
		return health
	set(value):
		if player_vulnerable or value > health :
			health = min(value, max_health)
			player_vulnerable = false
			player_invulnerable_timer()
			player_hit_sound.play()
			stat_change.emit()
		
var player_pos : Vector2

func player_invulnerable_timer() :
	await get_tree().create_timer(0.5).timeout
	player_vulnerable = true
	
func _ready():
	player_hit_sound = AudioStreamPlayer2D.new()
	player_hit_sound.stream = load("res://audio/solid_impact.ogg")
	add_child(player_hit_sound)
