extends Panel

onready var weapons_list = $Inventory_List/Weapons_Center_Container/Weapons_List.get_children()

func add_weapons():
	if PlayerControll.items.size() > 0:
		for weapon in weapons_list.size():
				weapon = PlayerControll.items[weapon]

func _process(_delta):
	add_weapons()
