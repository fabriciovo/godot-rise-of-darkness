extends Node
var save_dir = "user://"
var door_name = null

var stop = false
var dialog = false
var dead_enemies = []
var open_chests = []
var dead_objects = []
var walls_objects = []
var key_gate = []
var cutscene = false

var player_last_position = Vector2.ZERO
var player_last_scene = ""

var altar_hit = false
var boss_gate = false

var chest_sword = false
var chest_heal = false
var chest_bow = false
var chest_bomb = false
var execute_start_animation = true
var trigger_tutorial_animation = false
var in_game = false
var quest_menu = false

var dark_mages = {
	right_florest_dark_mage = false,
	left_florest_dark_mage = false,
	dungeon_dark_mage = false,
}

const GROUPS = {
	PLAYER = "PLAYER",
	BOX = "BOX",
	DOOR = "DOOR", 
	DOOR_WITH_INTERACTION = "DOOR_WITH_INTERACTION", 
	ENEMY = "ENEMY", 
	BOMB = "BOMB", 
	STATIC = "STATIC", 
	ARROW = "ARROW",
	MOVABLE = "MOVABLE",  
	TILEMAP = "TILEMAP",
	SWORD = "SWORD", 
	ARROW_AREA = "ARROW_AREA",
	SHIELD = "SHIELD",
	ENEMY_PROJECTILES = "ENEMY_PROJECTILES"
}

const WEAPONS = {
	SWORD = 0,
	BOW = 1, 
	BOMB = 2, 
	HEAL = 3,
	KEY = 4,
	SHIELD = 5,
}

const RELICS = {
	BOOTS_OF_SPEED = 0,
	RING_OF_DASH = 1,
	NECKLACE_OF_PROTECTION = 2, 
	RING_OF_SOULS = 3,
}

var QUESTS = {
	"FIND_WANNY": {
		"Title": "Find Wanny in lost woods",
		"Description": "",
		"Unlocked": false
	},
	"SOULS_QUEST": {
		"Title": "Collect souls",
		"Description": "COLLECT_SOULS_DESCRIPTION",
		"Reward": "Reward 50 XP",
		"Progress": 0,
		"Goal": 100,
		"Unlocked": false
	},
	"DEFEAT_DARK_MAGES": {
		"Title": "Defeat the Dark Mages",
		"Description": "COLLECT_SOULS_DESCRIPTION",
		"Reward": "Reward 50 XP",
		"Progress": 0,
		"Goal": 100,
		"Unlocked": false
		}
}

func get_world_data():
	var data = {
		"dead_enemies": dead_enemies,
		"open_chests": open_chests,
		"dead_objects": dead_objects,
		"walls_objects": walls_objects,
		"key_gate": key_gate,
		"cutscene": cutscene,
		"player_last_position": player_last_position,
		"player_last_scene": player_last_scene,
		"altar_hit": altar_hit,
		"boss_gate": boss_gate,
		"chest_sword": chest_sword,
		"chest_heal": chest_heal,
		"chest_bow": chest_bow,
		"chest_bomb": chest_bomb,
		"execute_start_animation": execute_start_animation,
		"trigger_tutorial_animation": trigger_tutorial_animation,
		"quest_menu": quest_menu,
		"dark_mages": dark_mages
	}
	return data

func set_world_data(data):
	if data.has("dead_enemies"):
		dead_enemies = data["dead_enemies"]
	if data.has("open_chests"):
		open_chests = data["open_chests"]
	if data.has("dead_objects"):
		dead_objects = data["dead_objects"]
	if data.has("walls_objects"):
		walls_objects = data["walls_objects"]
	if data.has("key_gate"):
		key_gate = data["key_gate"]
	if data.has("cutscene"):
		cutscene = data["cutscene"]
	if data.has("player_last_position"):
		player_last_position = data["player_last_position"]
	if data.has("player_last_scene"):
		player_last_scene = data["player_last_scene"]
	if data.has("altar_hit"):
		altar_hit = data["altar_hit"]
	if data.has("boss_gate"):
		boss_gate = data["boss_gate"]
	if data.has("chest_sword"):
		chest_sword = data["chest_sword"]
	if data.has("chest_heal"):
		chest_heal = data["chest_heal"]
	if data.has("chest_bow"):
		chest_bow = data["chest_bow"]
	if data.has("chest_bomb"):
		chest_bomb = data["chest_bomb"]
	if data.has("execute_start_animation"):
		execute_start_animation = data["execute_start_animation"]
	if data.has("trigger_tutorial_animation"):
		trigger_tutorial_animation = data["trigger_tutorial_animation"]
	if data.has("quest_menu"):
		quest_menu = data["quest_menu"]
	if data.has("dark_mages"):
		dark_mages = data["dark_mages"]

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

func save_world_data():
	saveJSONData("world_data", get_world_data())

func load_world_data():
	var data = loadJSONData("world_data")
	set_world_data(data)
