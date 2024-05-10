extends Area2D

onready var player = get_parent()

var orbit_radius = 16  
var orbit_speed = 3   
var angle = 0      
var knockback_vector = Vector2.LEFT
 
func _ready():
	add_to_group(Global.GROUPS.SHIELD)

func _process(_delta):
	angle += orbit_speed * _delta
	var x = player.global_position.x + orbit_radius * cos(angle)
	var y = player.global_position.y + orbit_radius * sin(angle)
	global_position = Vector2(x, y)

func _on_Neck_Of_Protection_body_entered(body):
	if body.is_in_group(Global.GROUPS.ENEMY):
		body.speed = (body.speed * -1) * 2
	
