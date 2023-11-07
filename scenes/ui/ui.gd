extends CanvasLayer

# colors
var green : Color = Color("#33FF33")
var red : Color = Color("#FF3333")

@onready var laser_label : Label = $LaserCounter/VBoxContainer/Label
@onready var grenade_label : Label = $GrenadeCounter/VBoxContainer/Label
@onready var laser_icon : TextureRect = $LaserCounter/VBoxContainer/TextureRect
@onready var grenade_icon : TextureRect = $GrenadeCounter/VBoxContainer/TextureRect
@onready var player_healthbar : TextureProgressBar = $MarginContainer/TextureProgressBar

func _ready() :
	Globals.connect("health_change", update_health_text)
	update_laser_text()
	update_grenade_text()
	update_health_text()

func update_laser_text() : 
	laser_label.text = str(Globals.laser_amount)
	get_label_color(Globals.laser_amount, laser_label, laser_icon)
	
func update_grenade_text() : 
	grenade_label.text = str(Globals.grenade_amount)
	get_label_color(Globals.grenade_amount, grenade_label, grenade_icon)
	
func get_label_color(amount : int, label : Label, icon : TextureRect) -> void :
	label.modulate = green if amount > 0 else red
	icon.modulate = green if amount > 0 else red
	
func update_health_text() :
	player_healthbar.value = Globals.health
