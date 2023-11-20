extends Area2D

var mushroom = preload("res://Assets/Enemy/World Enemy/World_Mushroom.tscn")
var rng = RandomNumberGenerator.new()
var count = 1
var collision = false

func _ready():
	rng.randomize()
	count = rng.randi_range(1, 4)
	for i in count:
		random_spawn()


func random_spawn():
	var random_position = Vector2(randi() % 100, randi() % 70)
	is_position_ocupied(random_position)
	get_overlap_body()
	print(random_position)
	print(collision)
	if not collision:
		var monster = mushroom.instance()
		monster.position = random_position
		add_child(monster)
	else:
		random_spawn()
	

func get_overlap_body():
	for node in get_overlapping_areas():
		print(node)
		if node:
				print(node)
				collision = true
	collision = false

func is_position_ocupied(random_position): 
	position = random_position
