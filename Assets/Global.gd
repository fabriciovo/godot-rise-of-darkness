extends Node

var doorName = null
var last_enemy = ""
var last_player_scene = ""

var stop = false
var dead_enemies = []
var open_chests = []
var dead_objects = []

var enemy_battle_unit_hp = 10
var enemy_battle_unit_damage = 10
var enemy_frame = 1
var enemy_battle_unit_type = ""
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

