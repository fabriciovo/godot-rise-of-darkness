extends Area2D

var knockback_vector = Vector2.ZERO

func _ready():
	add_to_group(Global.GROUPS.SHIELD)
