extends Node2D

export(String, "alt_sides_1","alt_sides_2", "alt_wood_sides" ) var anim_name = "alt_sides_1"

onready var anim = $Animation_Player
var smoke = preload("res://Assets/Animations/smoke.tscn")


func _ready():
	anim.play(anim_name)
	
	
func _exit_tree():
	var _inst_smoke = smoke.instance()
	position = _inst_smoke.position
	get_tree().current_scene.add_child(_inst_smoke)

