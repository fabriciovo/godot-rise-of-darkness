class_name Room_Controll extends Node2D

func _ready():
	var scene_name = get_tree().current_scene.name
	if not "World_0" in scene_name:
		Global.saveJSONData("player_data",PlayerControll.player_data())
		Global.save_world_data()
	queue_entities()
	queue_enviroment()
	if Global.door_name:
		var door_node = find_node(Global.door_name)
		if door_node:
			$Player.global_position = door_node.global_position
	if Global.player_last_scene != "" and Global.player_last_position != Vector2.ZERO:
		$Player.global_position = Global.player_last_position
		Global.player_last_scene = ""
		Global.player_last_position = null
	if "World_" in scene_name:
		SoundController.play_music(SoundController.MUSIC.florest)
	elif "Dungeon_" in scene_name:
		SoundController.play_music(SoundController.MUSIC.dungeon)
	elif scene_name == "Dungeon_Mini_Boss":
		SoundController.play_music(SoundController.MUSIC.miniboss)
	elif scene_name == "Dungeon_9":
		SoundController.play_music(SoundController.MUSIC.boss)
	if scene_name == "Dungeon_0" and Global.door_name == "Dungeon_exit":
		Ui.show_text("The Dungeon")

func queue_enviroment():
	if not get_node_or_null("Enviroment_Entities"): return
	for env_entity in get_node("Enviroment_Entities").get_children():
		for id in Global.key_gate.size():
			if env_entity.ID == Global.key_gate[id]:
				env_entity.queue_free()
		for id in Global.open_chests.size():
			if env_entity.ID == Global.open_chests[id]:
				env_entity.disable = true
				env_entity.get_node("Sprite").frame = 0
		for id in Global.dead_objects.size():
			if env_entity.ID == Global.dead_objects[id]:
				env_entity.queue_free()
		for id in Global.walls_objects.size():
			if env_entity.ID == Global.walls_objects[id]:
				env_entity.queue_free()

func queue_entities():
	if not has_node("Entities"): return
	var entities_node = get_node("Entities")
	var entities = entities_node.get_children()
	for entity in entities:
		for enemy in Global.dead_enemies:
			if typeof(enemy) == TYPE_DICTIONARY:
				if entity.ID == enemy["id"]:
					if enemy["soul"]:
						entity.create_soul()
					entity.queue_free()
