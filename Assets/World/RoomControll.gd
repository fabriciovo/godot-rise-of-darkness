extends Node


func _ready():
	if Global.doorName and Global.last_player_scene == "":
		var door_node = find_node(Global.doorName)
		if door_node:
			$Player.global_position = door_node.global_position
	if Global.player_last_scene != "" and Global.player_last_position != Vector2.ZERO:
		$Player.global_position = Global.player_last_position
		Global.player_last_scene = ""
		Global.player_last_position = null
		
	for m in get_node("Entities").get_children():
		for id in Global.dead_enemies.size():
			if m.ID == Global.dead_enemies[id]:
				m.queue_free()
				
		for id in Global.open_chests.size():
			if m.ID == Global.open_chests[id]:
				m.disable = true
				m.get_node("Sprite").frame = 0
				
		for id in Global.dead_objects.size():
			if m.ID == Global.dead_objects[id]:
				m.queue_free()
	if get_tree().current_scene.name == "World_0":
		SoundController.play_music(SoundController.MUSIC.florest)
	elif get_tree().current_scene.name == "Dungeon_0":
		SoundController.play_music(SoundController.MUSIC.florest)
	elif get_tree().current_scene.name == "Dungeon_Mini_Boss":
		SoundController.play_music(SoundController.MUSIC.miniboss)
	elif get_tree().current_scene.name == "Dungeon_9":
		SoundController.play_music(SoundController.MUSIC.boss)



