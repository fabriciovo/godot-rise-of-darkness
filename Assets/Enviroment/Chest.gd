class_name Chest
extends Area2D

export(int) var item
var ID = ""
var disable = false
var player = null

onready var interactButton = get_node("InteractionButton")

func _ready():
	interactButton.visible = false;
	ID = name

func _input(event):
	if event.is_action_pressed("action_3") and not disable:
		if player:
			disable = true
			player.get_item_frame = item
			player.play_get_item_animation()
			get_weapon(item)

func get_weapon(_item):
	$Sprite.frame = 0
	match _item:
		Global.WEAPONS.SWORD:
			PlayerControll.set_inventory_item(_item)
			Global.open_chests.push_front(ID)
			Global.trigger_tutorial_animation = true
		Global.WEAPONS.BOW:
			PlayerControll.set_inventory_item(_item)
			Global.open_chests.push_front(ID)
		Global.WEAPONS.BOMB:
			PlayerControll.set_inventory_item(_item)
			Global.open_chests.push_front(ID)
		Global.WEAPONS.HEAL:
			PlayerControll.set_inventory_item(_item)
			Global.open_chests.push_front(ID)
		Global.WEAPONS.KEY:
			PlayerControll.key += 1
			Global.open_chests.push_front(ID)

func _on_Chest_body_entered(body):
	if body.is_in_group(Global.GROUPS.PLAYER) and not disable:
		player = body

func _on_Chest_body_exited(body):
	if body.is_in_group(Global.GROUPS.PLAYER):
		player = null
