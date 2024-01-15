extends Panel

onready var weapons_list = $Inventory_List/Weapons_Center_Container/Weapons_List.get_children()

func add_weapons():
	if PlayerControll.items.size() > 0:
		for i in range(min(PlayerControll.items.size(), weapons_list.size())):
			weapons_list[i].set_weapon_type(PlayerControll.items[i])

func _process(_delta):
	add_weapons()
