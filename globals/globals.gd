extends Node

signal health_change

var laser_amount = 20

var grenade_amount = 10

var health = 60 : 
	get: 
		print("Health value was read")
		return health
	set(value):
		health = value
		health_change.emit()
		print("Health value was set")
