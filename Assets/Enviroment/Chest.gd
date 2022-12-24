class_name Chest
extends Area2D

export(int) var item
var ID = ""
var disable = false

onready var interactButton = get_node("InteractionButton")

func _ready():
	interactButton.visible = false;
	ID = name

func _process(delta):
	if get_overlapping_areas().size() > 0:
		interactButton.visible = true;
	else:
		interactButton.visible = false;

func _input(event):
	if event.is_action_pressed("action_3") and not disable:
		if get_overlapping_areas().size() > 0:
			get_item(item)

func get_item(item):
	$Sprite.frame = 0
	match item:
		Global.WEAPONS.SWORD:
			PlayerControll.set_item(item)
			Global.open_chests.push_front(ID)
		Global.WEAPONS.BOW:
			PlayerControll.set_item(item)
			Global.open_chests.push_front(ID)
		Global.WEAPONS.BOMB:
			PlayerControll.set_item(item)
			Global.open_chests.push_front(ID)
		Global.WEAPONS.HEAL:
			PlayerControll.set_item(item)
			Global.open_chests.push_front(ID)
		Global.WEAPONS.KEY:
			PlayerControll.key += 1
			Global.open_chests.push_front(ID)
	disable = true


