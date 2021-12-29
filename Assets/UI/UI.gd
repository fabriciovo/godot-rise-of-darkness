extends Control

export (PackedScene) var Player

onready var HP = $Items/Stats/HP
onready var MP = $Items/Stats/MP
onready var AP = $Items/Stats/AP
onready var item_1 = $Items/item1/weapon
onready var item_2 = $Items/item2/weapon

# variable where we store the player
var player


func _ready():
	# create the player and store it in the "player" variable
	player = Player.instance()
	HP.text = "HP " + str(player.hp)
	MP.text = "MP " + str(player.mp)
	AP.text = "AP " + str(player.ap)
	
	if player.equiped_item[0] <= 0:
		item_1.visible = false
	else:
		item_1.visible = true
		item_1.frame = player.equiped_item[0]
		
	if player.equiped_item[1] <= 0:
		item_2.visible = false
	else:
		item_2.visible = true
		item_2.frame = player.equiped_item[1]



func _on_Player_hp_changed(value):
	HP.text = "HP " + str(value)


func _on_Player_equiped_item(value, slot):
	if slot == 0:
		item_1.frame = value 
		item_1.visible = true
	else:
		item_2.frame = value 
		item_2.visible = true
