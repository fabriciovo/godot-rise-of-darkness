extends CanvasLayer

onready var HP = $Items/Stats/HP
onready var MP = $Items/Stats/MP
onready var AP = $Items/Stats/AP
onready var item_1 = $Items/item1/weapon
onready var item_2 = $Items/item2/weapon
onready var key_label = $Items/Stats/key/key_label

onready var inventory_sword = $Items/Inventory/sword
onready var inventory_heal = $Items/Inventory/heal
onready var inventory_bomb = $Items/Inventory/bomb
onready var inventory_bow = $Items/Inventory/bow

onready var level = $Stats/Level
onready var xp = $Stats/xp

var can_equip_sword = false
var can_equip_heal = false
var can_equip_bomb = false
var can_equip_bow = false

func _process(delta):
	if get_tree().current_scene.name == "Title_Scene" || get_tree().current_scene.name == "Game_Over" || get_tree().current_scene.name == "Win":
		visible = false
	else:
		visible = true
	HP.text = "HP " + str(PlayerControll.hp)
	MP.text = "MP " + str(PlayerControll.mp)
	AP.text = "AP " + str(PlayerControll.ap)
	key_label.text = str(PlayerControll.key) 
	level.text = "Level: " + str(PlayerControll.level)
	xp.text = "XP: " + str(PlayerControll.xp) + "/" + str(PlayerControll.xp_to_level_up)

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
				Global.WEAPONS.SWORD:
					inventory_sword.get_node("Sprite").visible = true
					can_equip_sword = true
				Global.WEAPONS.HEAL:
					inventory_heal.get_node("Sprite").visible = true
					can_equip_heal = true
				Global.WEAPONS.BOW:
					inventory_bow.get_node("Sprite").visible = true
					can_equip_bow = true
				Global.WEAPONS.BOMB:
					can_equip_bomb = true
					inventory_bomb.get_node("Sprite").visible = true

func _ready():
	inventory_sword.get_node("Sprite").visible = false
	inventory_bomb.get_node("Sprite").visible = false
	inventory_bow.get_node("Sprite").visible = false
	inventory_heal.get_node("Sprite").visible = false

func _on_PlayerControl_hp_changed(value):
	HP.text = "HP " + str(value)


func _on_heal_gui_input(event):
	if can_equip_heal:
		if event.is_action_pressed("action_1"):
			PlayerControll.set_equiped_item(Global.WEAPONS.HEAL, 0)
		if event.is_action_pressed("action_2"):
			PlayerControll.set_equiped_item(Global.WEAPONS.HEAL, 1)


func _on_bomb_gui_input(event):
	if can_equip_bomb:
		if event.is_action_pressed("action_1"):
			PlayerControll.set_equiped_item(Global.WEAPONS.BOMB, 0)
		if event.is_action_pressed("action_2"):
			PlayerControll.set_equiped_item(Global.WEAPONS.BOMB, 1)


func _on_bow_gui_input(event):
	if can_equip_bow:
		if event.is_action_pressed("action_1"):
			PlayerControll.set_equiped_item(Global.WEAPONS.BOW, 0)
		if event.is_action_pressed("action_2"):
			PlayerControll.set_equiped_item(Global.WEAPONS.BOW, 1)


func _on_sword_gui_input(event):
	if can_equip_sword:
		if event.is_action_released("action_1"):
			PlayerControll.set_equiped_item(Global.WEAPONS.SWORD, 0)
		if event.is_action_released("action_2"):
			PlayerControll.set_equiped_item(Global.WEAPONS.SWORD, 1)


func show_hidden_panels():
	$"Sound Panel".visible = !$"Sound Panel".visible
	$"Max Stats".visible = !$"Max Stats".visible

func open_sound_panel():
	$"Sound Panel".visible = !$"Sound Panel".visible
