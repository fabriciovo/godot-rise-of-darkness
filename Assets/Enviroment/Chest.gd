class_name Chest
extends Area2D

export(String, "weapons", "relics") var type = "weapons"
export(int, "Sword/Boot of Speed", 
"Bow/Ring of Dash",
"Bomb/necklace of protection", 
"Heal/Ring of souls", "Key", "Shield" ) var item = 0

onready var interactButton = get_node("InteractionButton")
onready var text_box = $Text_Box_Layer/Text_Box

var ID = ""
var disable = false
var player = null
var player_anim = null

func _ready():
	add_to_group(Global.GROUPS.STATIC)
	interactButton.visible = false;
	ID = name

func _input(_event):
	if _event.is_action_pressed("action_3") and not disable:
		Ui.check_if_settings_is_open()
		if player:
			disable = true
			Global.cutscene = true
			SoundController.stop_music()
			SoundController.play_effect(SoundController.EFFECTS.open_chest)
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
	text_box.dialog_name = "get_weapon_" + str(_item) + ".json"
	if _item == Global.WEAPONS.SWORD:
		Global.NPCS_QUEST_STEP_TRACK.Ronan+=1
		PlayerControll.set_inventory_item(_item)
	elif _item == Global.WEAPONS.KEY:
		PlayerControll.key+=1
	else:
		PlayerControll.set_inventory_item(_item)
	yield(player_anim, "animation_finished")
	text_box.start_dialog()

func get_relic(_item):
	$Sprite.frame = 0
	Global.open_chests.push_front(ID)
	text_box.dialog_name = "get_relic_" + str(_item) + ".json"
	PlayerControll.set_relic_item(_item)
	yield(player_anim, "animation_finished")
	text_box.start_dialog()

func _on_Chest_body_entered(body):
	if body.is_in_group(Global.GROUPS.PLAYER) and not disable:
		player = body
		player_anim= player.get_node("PlayerAnimation")

func _on_Chest_body_exited(body):
	if body.is_in_group(Global.GROUPS.PLAYER):
		player = null

func _on_Text_Box_on_end_dialog():
	Global.stop = false
	Global.cutscene = false
	SoundController.keep_music()
