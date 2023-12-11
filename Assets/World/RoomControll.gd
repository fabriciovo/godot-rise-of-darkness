extends Node

func _ready():
	Global.in_game = true
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
	for entity in get_node("Entities").get_children():
		for id in Global.dead_enemies.size():
			if entity.ID == Global.dead_enemies[id]:
				entity.queue_free()
		for id in Global.open_chests.size():
			if entity.ID == Global.open_chests[id]:
				entity.disable = true
				entity.get_node("Sprite").frame = 0
		for id in Global.dead_objects.size():
			if entity.ID == Global.dead_objects[id]:
				entity.queue_free()
		for id in Global.walls_objects.size():
			if entity.ID == Global.walls_objects[id]:
				entity.queue_free()
		for id in Global.key_gate.size():
			if entity.ID == Global.key_gate[id]:
				entity.queue_free()
	if "World_" in scene_name:
		SoundController.play_music(SoundController.MUSIC.florest)
	elif "Dungeon_" in scene_name:
		SoundController.play_music(SoundController.MUSIC.dungeon)
	elif scene_name == "Dungeon_Mini_Boss":
		SoundController.play_music(SoundController.MUSIC.miniboss)
	elif scene_name == "Dungeon_9":
		SoundController.play_music(SoundController.MUSIC.boss)
	if scene_name == "Dungeon_0":
		Ui.show_text("The Dungeon")
