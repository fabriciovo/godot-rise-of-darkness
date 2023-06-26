extends Node


func _ready():
	Global.saveJSONData("player_data",PlayerControll.player_data())
	var scene_name = get_tree().current_scene.name
	if Global.door_name and Global.last_player_scene == "":
		var door_node = find_node(Global.door_name)
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
	if "World_" in scene_name:
		SoundController.play_music(SoundController.MUSIC.florest)
	elif "Dungeon_" in scene_name:
		SoundController.play_music(SoundController.MUSIC.dungeon)
	elif scene_name == "Dungeon_Mini_Boss":
		SoundController.play_music(SoundController.MUSIC.miniboss)
	elif scene_name == "Dungeon_9":
		SoundController.play_music(SoundController.MUSIC.boss)
