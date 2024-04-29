extends Area2D

var orbit_radius = 16  
var orbit_speed = 3   
var angle = 0           
onready var player = get_parent()

func _process(_delta):
	angle += orbit_speed * _delta
	var x = player.global_position.x + orbit_radius * cos(angle)
	var y = player.global_position.y + orbit_radius * sin(angle)
	global_position = Vector2(x, y)
