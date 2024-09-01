extends Area2D

var knockback_vector = Vector2.ZERO

func _ready():
	add_to_group(Global.GROUPS.SHIELD)

func _on_Shield_Area_body_entered(_body):
	if _body.is_in_group(Global.GROUPS.ENEMY_PROJECTILES):
		get_parent().add_mp(3)
		_body.queue_free()

func _on_Shield_Area_area_entered(_area):
	if _area.is_in_group(Global.GROUPS.ENEMY_PROJECTILES):
		get_parent().add_mp(3)
		_area.queue_free()
