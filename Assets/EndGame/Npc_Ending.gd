extends Node2D

export(String, "alt_sides_1","alt_sides_2", "alt_wood_side" ) var anim_name

onready var anim = $Animation_Player
var smoke = preload("res://Assets/Animations/smoke.tscn")

func _ready():
	anim.play(anim_name)
