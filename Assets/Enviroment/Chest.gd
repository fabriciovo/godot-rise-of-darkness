class_name Chest
extends Area2D

export(int) var item
export(String) var ID
var disable = false

func _input(event):
	if event.is_action_pressed("action_1") and not disable:
		if get_overlapping_areas().size() > 0:
			get_item(item)

func get_item(item):
	$Sprite.frame = 0
	match item:
		Global.WEAPONS.SWORD:
			PlayerControll.set_item(item)
			Global.dead_enemies.push_front(ID)
		Global.WEAPONS.BOW:
			PlayerControll.set_item(item)
			Global.dead_enemies.push_front(ID)
		Global.WEAPONS.BOMB:
			PlayerControll.set_item(item)
			Global.dead_enemies.push_front(ID)
		Global.WEAPONS.HEAL:
			PlayerControll.set_item(item)
			Global.dead_enemies.push_front(ID)
		4:
			PlayerControll.key += 1
			Global.dead_enemies.push_front(ID)
	disable = true


