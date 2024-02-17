class_name Chest
extends Area2D

export(int) var item
export(String, "weapons", "relics") var type = "weapons"
var ID = ""
var disable = false
var player = null

onready var interactButton = get_node("InteractionButton")

func _ready():
	interactButton.visible = false;
	ID = name

func _input(event):
	if event.is_action_pressed("action_3") and not disable:
		Ui.check_if_settings_is_open()
		if player:
			disable = true
			if type == "weapons":
				player.set_item_texture(item, type)
				player.play_get_item_animation()
				get_weapon(item)
			else:
				player.set_item_texture(item, type)
				player.play_get_item_animation()
				get_relic(item)

func get_weapon(_item):
	$Sprite.frame = 0
	Global.open_chests.push_front(ID)
	match _item:
		Global.WEAPONS.SWORD:
			PlayerControll.set_inventory_item(_item)
			yield(get_tree().create_timer(3),"timeout")
			Global.trigger_tutorial_animation = true
		Global.WEAPONS.KEY:
			PlayerControll.key += 1
		_:
			PlayerControll.set_inventory_item(_item)

func get_relic(_item):
	$Sprite.frame = 0
	Global.open_chests.push_front(ID)
	PlayerControll.set_relic_item(_item)


func _on_Chest_body_entered(body):
	if body.is_in_group(Global.GROUPS.PLAYER) and not disable:
		player = body

func _on_Chest_body_exited(body):
	if body.is_in_group(Global.GROUPS.PLAYER):
		player = null
