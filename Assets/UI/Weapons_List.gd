extends HBoxContainer


onready var childrens = get_children()

func _process(_delta):
	for _weapon_index in PlayerControll.weapons.size():
		childrens[_weapon_index].weapon_type = PlayerControll.weapons[_weapon_index]

