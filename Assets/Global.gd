extends Node
var saveFilePath = "user://1-bit-hero-player.json"
var doorName = null
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

func save_game_data():
	var file = File.new()
	if file.open(saveFilePath, File.WRITE) == OK:
		file.store_var(global_data())
		file.close()
		print("Game data saved.")
	if file.open(saveFilePath, File.WRITE) == OK:
		file.store_var(PlayerControll.player_data())
		file.close()
		print("Game data saved.")


func load_global_data(data):
	dead_enemies = data["dead_enemies"]
	open_chests = data["open_chests"]
	dead_objects = data["dead_objects"] 


func load_game_data():
	var file = File.new()
	if file.open(saveFilePath, File.READ) == OK:
		var data = file.get_var()
		file.close()
		if data:
			PlayerControll.load_player_data(data)
			load_global_data(data)
			get_tree().change_scene("res://Assets/World/World_0.tscn")
		else:
			print("Failed to load game data.")
	else:
		print("Failed to open save file.")
