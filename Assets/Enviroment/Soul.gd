class_name Soul extends Node2D

var ID = ""

func _on_Area2D_body_entered(body):
	if body.is_in_group(Global.GROUPS.PLAYER):
		for enemy in Global.dead_enemies:
			if typeof(enemy) == TYPE_DICTIONARY and enemy.has("id"):
				if enemy["id"] == ID:
					enemy["soul"] = false
			queue_free()
