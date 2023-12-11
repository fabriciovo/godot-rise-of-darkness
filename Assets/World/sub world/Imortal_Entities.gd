extends Node2D

onready var positions = $Positions.get_children()
var mushroom = preload("res://Assets/Enemy/World Enemy/World_Mushroom.tscn")
var rng = RandomNumberGenerator.new()
var spawns_count = 0
var position_index = 0
var collision = false

func _ready():
	rng.randomize()
	spawns_count = rng.randi_range(1, 3)
	for i in spawns_count:
		random_spawn()


func random_spawn():
	rng.randomize()
	position_index = rng.randi_range(0, positions.size()-1)
	var random_position = positions[position_index].position
	var monster = mushroom.instance()
	monster.position = random_position
	add_child(monster)
