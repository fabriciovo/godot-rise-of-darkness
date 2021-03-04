extends Node2D

var hp = 25 setget set_hp

onready var hpLabel = $HPLabel

func set_hp(new_hp):
	hp = new_hp
	hpLabel.text = str(hp) + "hp"



