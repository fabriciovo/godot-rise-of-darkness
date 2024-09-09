class_name Soul extends Node2D

onready var collect_area = $Collect_Area

var ID = ""

func _ready():
	add_to_group(Global.GROUPS.SOUL)
	if !PlayerControll.ring_of_souls:
		visible = false
		collect_area.monitoring = false
		collect_area.monitorable = false

func _on_Area2D_body_entered(body):
	if body.is_in_group(Global.GROUPS.PLAYER) and PlayerControll.ring_of_souls:

		for enemy in Global.dead_enemies:
			if typeof(enemy) == TYPE_DICTIONARY and enemy.has("id"):
				if enemy["id"] == ID:
					enemy["soul"] = false
					Global.QUESTS["SOULS_QUEST"].Progress += 1
					PlayerControll.set_hp(PlayerControll.hp+1)
					PlayerControll.set_mp(PlayerControll.mp+1)
					PlayerControll.set_xp(1)
					if Global.QUESTS["SOULS_QUEST"].Progress == Global.QUESTS["SOULS_QUEST"].Goal:
						Global.QUESTS["SOULS_QUEST"].Completed = true
			queue_free()
