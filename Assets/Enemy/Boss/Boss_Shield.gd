extends KinematicBody2D


var radius = 33.0
var angle = 0.0
onready var center_sprite = get_node("Sprite")

export(int) var x_pos
export(int) var y_pos
export(int) var dir
var battle_unit_damage = 5
func _ready():
	add_to_group(Global.GROUPS.ENEMY)

func _process(_delta):
	angle += 0.1 / 10
	var x = center_sprite.position.x + x_pos + radius * cos(angle) * dir
	var y = center_sprite.position.y  + radius * sin(angle)
	position = Vector2(x, y )
	rotation = angle


