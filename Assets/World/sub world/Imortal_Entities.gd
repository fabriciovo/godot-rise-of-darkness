extends Area2D

var mushroom = preload("res://Assets/Enemy/World Enemy/World_Mushroom.tscn")
var positions = $Positions.get_children()
var rng = RandomNumberGenerator.new()
var spawns_count = 0
var position_number = 0
var collision = false

func _ready():
	rng.randomize()
	spawns_count = rng.randi_range(1, 4)
	position_number = rng.randi_range(0, positions.size())
	for i in spawns_count:
		random_spawn()


func random_spawn():
	var random_position = Vector2(randi() % 120, randi() % 50)
	var monster = mushroom.instance()
	monster.position = random_position
	add_child(monster)
