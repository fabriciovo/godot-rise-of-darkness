extends Node
var save_dir = "user://"
var door_name = null
var last_enemy = ""
var last_player_scene = ""

var stop = false
var dead_enemies = []
var open_chests = []
var dead_objects = []

var player_last_position = Vector2.ZERO
var player_last_scene = ""

var altar_hit = false
var boss_gate = false
var key_gate = false

var chest_sword = false
var chest_heal = false
var chest_bow = false
var chest_bomb = false

var GROUPS = {
	PLAYER = "PLAYER",
	BOX = "BOX",
	DOOR = "DOOR", 
	ENEMY = "ENEMY", 
	BOMB = "BOMB", 
	STATIC = "STATIC", 
	ARROW = "ARROW",
	MOVABLE = "MOVABLE",  
	TILEMAP = "TILEMAP",
	SWORD = "SWORD", 
	ARROW_AREA = "ARROW_AREA"
}

var WEAPONS = {
	SWORD = 0,
	BOW = 1, 
	BOMB = 2, 
	HEAL = 4,
	KEY = 5
}

func global_data():
	var data = {
		"dead_enemies": dead_enemies,
		"open_chests": open_chests,
		"dead_objects": dead_objects,
	}
	return data

func saveJSONData(file_name, data):
	var file_path = save_dir + file_name + ".json"
	var file = File.new()
	file.open(file_path, File.WRITE)
	file.store_line(to_json(data))
	file.close()

func loadJSONData(file_name):
	var file_path = save_dir + file_name + ".json"
	var file = File.new()
	if file.file_exists(file_path):
		if file.open(file_path, File.READ) == OK:
			var json_data = file.get_line()
			file.close()
			if json_data != "":
				var data = parse_json(json_data)
				if data:
					return data
				else:
					printerr("Failed to parse JSON data from file:", file_name)
					var _change_scene = get_tree().change_scene("res://Assets/TitleScene/Title_Scene.tscn")
					
			else:
				printerr("Empty JSON data in file:", file_name)
				var _change_scene = get_tree().change_scene("res://Assets/TitleScene/Title_Scene.tscn")
		else:
			printerr("Failed to open file:", file_name)
			var _change_scene = get_tree().change_scene("res://Assets/TitleScene/Title_Scene.tscn")
	else:
		printerr("File does not exist:", file_name)
		var _change_scene = get_tree().change_scene("res://Assets/TitleScene/Title_Scene.tscn") 
	return null
