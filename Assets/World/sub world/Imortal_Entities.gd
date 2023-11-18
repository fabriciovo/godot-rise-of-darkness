extends Node2D

var mushroom = preload("res://Assets/Enemy/World Enemy/World_Mushroom.tscn")
var rng = RandomNumberGenerator.new()
var count = 1

func _ready():
	rng.randomize()
	var count = rng.randi_range(1, 4)
	print(count)
	for i in count:
		random_spawn()

func random_spawn():
	var random_position = Vector2(randi() % 225, randi() % 142)
	var collision = is_position_ocupied(random_position)
	if not collision:
		var monster = mushroom.instance()
		monster.position = random_position
		add_child(monster)
	else:
		$Check_If_Place_Free.queue_free()
		random_spawn()
	


func is_position_ocupied(position):
	var area = $Check_If_Place_Free 
	area.position = position
	var collision = area.get_overlapping_bodies()
	return collision
