extends Node
var save_dir = "user://save_data/"
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

#func save_game_data():
#	var file = File.new()
#	if file.open(saveFilePath, File.WRITE) == OK:
#		file.store_var(global_data())
#		file.close()
#		print("Game data saved.")
#	if file.open(saveFilePath, File.WRITE) == OK:
#		file.store_var(PlayerControll.player_data())
#		file.close()
#		print("Game data saved.")

func saveJSONData(fileName, data):
	print(data)
	var file_path = save_dir + fileName + ".json"
	var file = File.new()
	file.open(file_path, File.WRITE)
	file.store_line(to_json(data))
	file.close()


func loadJSONData(fileName):
	var filePath = save_dir + fileName + ".json"
	var file = File.new()
	if file.file_exists(filePath):
		if file.open(filePath, File.READ) == OK:
			var jsonData = file.get_line()
			file.close()
			if jsonData != "":
				var data = parse_json(jsonData)
				if data:
					print("Loaded JSON data from file:", fileName)
					return data
				else:
					print("Failed to parse JSON data from file:", fileName)
			else:
				print("Empty JSON data in file:", fileName)
		else:
			print("Failed to open file:", fileName)
	else:
		print("File does not exist:", fileName)
	return null
