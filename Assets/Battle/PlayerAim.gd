extends KinematicBody2D

onready var main = get_tree().current_scene

var areas = null
var array_areas = []
var active = false
var dir = Vector2.ZERO
var speed = 10
var area_name = ""

func randomArea():
	var minValue = 0
	var maxValue = array_areas.size()
	return lerp(minValue, maxValue, randf())

func getDir():
	if active:
		var direction = array_areas[randomArea()].global_position
		dir = (direction - global_position).normalized()
	else:
		dir = Vector2.ZERO
func _ready():
	print(areas)
	if areas:
		print(areas)
		for area in areas:
			array_areas.append(area)
	getDir()

func _process(delta):
	if active:
		move_and_collide(dir * 0.3)
		areas = main.get_node("EnemyPosition")
		print(areas)


func _on_Timer_timeout():
	if active:
		$Timer.start(0.5)
		getDir()

func _on_Area_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	area_name = area.name

func _on_Area_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	area_name = ""
