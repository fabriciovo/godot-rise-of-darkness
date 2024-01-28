extends Control

onready var weapons_list = $Weapons_Container.get_children()


func _ready():
	pass

func _process(_delta):
	for weapon in weapons_list:
		weapon.text = "?????"
		
