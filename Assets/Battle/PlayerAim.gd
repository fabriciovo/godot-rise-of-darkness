extends KinematicBody2D


onready var areas = get_parent().get_node("EnemyPostion/Enemy").get_node("Areas").get_children()
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
	if array_areas:
		var direction = array_areas[randomArea()].global_position
		dir = (direction - global_position).normalized()
	else:
		dir = Vector2.ZERO
func _ready():
	for area in areas:
		array_areas.append(area)
	getDir()

func _process(delta):
	if active:
		move_and_collide(dir * 0.3)


func _on_Timer_timeout():
	$Timer.start(0.5)
	getDir()


func _on_Area_area_entered(area):
	area_name = area.name


func _on_Area_area_exited(area):
	area_name = ""
