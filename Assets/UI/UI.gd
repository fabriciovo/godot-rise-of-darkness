extends Control



onready var HP = $Items/Stats/HP
onready var MP = $Items/Stats/MP
onready var AP = $Items/Stats/AP
onready var item_1 = $Items/item1/weapon
onready var item_2 = $Items/item2/weapon

onready var inventory_sword = $Items/Inventory/sword
onready var inventory_heal = $Items/Inventory/heal
onready var inventory_bomb = $Items/Inventory/bomb
onready var inventory_bow = $Items/Inventory/bow

func _process(delta):
	HP.text = "HP " + str(PlayerControll.hp)
	MP.text = "MP " + str(PlayerControll.mp)
	AP.text = "AP " + str(PlayerControll.ap)
	if PlayerControll.equiped_item[0] < 0:
		item_1.visible = false
	else:
		item_1.visible = true
		item_1.frame = PlayerControll.equiped_item[0]
		
	if PlayerControll.equiped_item[1] < 0:
		item_2.visible = false
	else:
		item_2.visible = true
		item_2.frame = PlayerControll.equiped_item[1]
		
	for i in PlayerControll.items.size():
		 match PlayerControll.items[i]:
				"sword":
					inventory_sword.get_node("Sprite").visible = true
					inventory_sword.get_node("Sprite").frame = 0
				"heal":
					inventory_heal.get_node("Sprite").visible = true
					inventory_heal.get_node("Sprite").frame = 3
				"bow":
					inventory_bow.get_node("Sprite").visible = true
					inventory_bow.get_node("Sprite").frame = 1
				"bomb":
					inventory_bomb.get_node("Sprite").visible = true
					inventory_bomb.get_node("Sprite").frame = 2


func _ready():
	inventory_sword.get_node("Sprite").visible = false
	inventory_bomb.get_node("Sprite").visible = false
	inventory_bow.get_node("Sprite").visible = false
	inventory_heal.get_node("Sprite").visible = false
	# create the player and store it in the "player" variable
	HP.text = "HP " + str(PlayerControll.hp)
	MP.text = "MP " + str(PlayerControll.mp)
	AP.text = "AP " + str(PlayerControll.ap)
	
	if PlayerControll.equiped_item[0] < 0:
		item_1.visible = false
	else:
		item_1.visible = true
		item_1.frame = PlayerControll.equiped_item[0]
		
	if PlayerControll.equiped_item[1] < 0:
		item_2.visible = false
	else:
		item_2.visible = true
		item_2.frame = PlayerControll.equiped_item[1]
		
	for i in PlayerControll.items.size():
		 match PlayerControll.items[i]:
				"sword":
					inventory_sword.get_node("Sprite").visible = true
					inventory_sword.get_node("Sprite").frame = 0
				"heal":
					inventory_heal.get_node("Sprite").visible = true
					inventory_heal.get_node("Sprite").frame = 2
				"bow":
					inventory_bow.get_node("Sprite").visible = true
					inventory_bow.get_node("Sprite").frame = 1
				"bomb":
					inventory_bomb.get_node("Sprite").visible = true
					inventory_bomb.get_node("Sprite").frame = 3


func _on_Player_equiped_item(value, slot):
	if slot == 0:
		item_1.frame = value 
		item_1.visible = true
	else:
		item_2.frame = value 
		item_2.visible = true


func _on_PlayerControl_hp_changed(value):
	HP.text = "HP " + str(value)




func _on_sword_input(value):
	PlayerControll.set_equiped_item(0,value)


func _on_bow_input(value):
	PlayerControll.set_equiped_item(1,value)


func _on_bomb_input(value):
	PlayerControll.set_equiped_item(3,value)


func _on_heal_input(value):
	PlayerControll.set_equiped_item(2,value)


func _on_sword_pressed():
	pass # Replace with function body.
