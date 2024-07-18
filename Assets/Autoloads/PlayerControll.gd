extends Node

var max_hp = 200
var max_ap = 3
var max_mp = 200
var hp = max_hp setget set_hp
var ap = max_ap setget set_ap
var mp = max_mp setget set_mp
var xp = 0 setget set_xp 
var xp_to_level_up = 100 setget set_xp_to_level_up
var level = 1 setget set_level
var atk = 3 setget set_atk
var points = 0 setget set_points
var weapons = [-1,-1,-1,-1]
var inventory = []
var equiped_item = [0,1] 
var relics = []
var key = 0
var base_speed = 30
var dash_unlocked = false
var neck_of_protection = false
var ring_of_souls = false
var armor_of_light = false

var float_text = preload("res://Assets/UI/FloatText.tscn")

func increase_max_hp():
	points-=1
	max_hp += 1
	hp = max_hp

func increase_max_mp():
	points -= 1
	max_mp += 1
	mp = max_mp

func increase_max_ap():
	points-=1
	max_ap += 1

func increase_atk():
	points-=1
	atk += 1

func set_hp(value):
	hp = clamp(value, 0 , max_hp)
	if hp <= 0:
		var scene_instance = get_tree().change_scene("res://Assets/GameOver/Game_Over.tscn")
		if scene_instance == OK:
			PlayerControll.load_player_data(Global.loadJSONData("player_data"))

func set_ap(value):
	ap = clamp(value, 0 , max_ap)

func set_mp(value):
	mp = min(value, max_mp)

func set_inventory_item(value):
	inventory.push_front(value)
	for i in weapons.size():
		if weapons[i] == -1:
			set_weapon(value)
			return


func set_relic_item(value):
	match value:
		Global.RELICS.BOOTS_OF_SPEED:
			base_speed = 40
		Global.RELICS.RING_OF_DASH:
			PlayerControll.dash_unlocked = true
		Global.RELICS.NECKLACE_OF_PROTECTION:
			PlayerControll.neck_of_protection = true
		_:
			pass
	relics.push_front(value)

func set_weapon(value):
	weapons.push_front(value)
	var weapon_list = get_node("/root/Ui").get_node("Game_UI")
	weapon_list.add_weapon(value)

func update_weapon_slot(_weapon_type,_slot):
	weapons[_slot] = _weapon_type
	var weapon_list = get_node("/root/Ui").get_node("Game_UI")
	weapon_list.update_weapon_slot(_weapon_type)

func set_equiped_item(value, slot):
	if equiped_item[0] == value: 
		equiped_item[0] = -1 
	elif equiped_item[1] == value: 
		equiped_item[1] = -1 
	equiped_item[slot] = value

func set_key(value):
	key -= value

func set_xp(value):
	xp += value
	if xp >= xp_to_level_up:
		points = level + 2
		level+=1
		xp_to_level_up = floor(xp_to_level_up * 1.2)
		xp =  xp_to_level_up - xp
		var xp_text = float_text.instance()
		xp_text.set_text("LEVEL UP!!")
		get_tree().get_current_scene().get_node("Player").add_child(xp_text)
func set_level(value):
	level = value

func set_xp_to_level_up(value):
	xp_to_level_up = value

func set_atk(value):
	atk = value

func set_points(value):
	points = value

func restart():
	set_hp(max_hp)
	set_mp(max_mp)
	set_ap(max_ap)

func player_data(): 
	var data = {
		"max_hp": max_hp,
		"max_ap": max_ap,
		"hp": hp,
		"ap": ap,
		"mp": mp,
		"xp": xp,
		"xp_to_level_up": xp_to_level_up,
		"atk": atk,
		"base_speed": base_speed,
		"points": points,
		"weapons": weapons,
		"inventory": inventory,
		"equiped_item": equiped_item,
		"key": key,
		"relics": relics,
	}
	return data

func load_player_data(data):
	if data.has("max_hp"):
		max_hp = data["max_hp"]
	if data.has("max_ap"):
		max_ap = data["max_ap"]
	if data.has("hp"):
		hp = data["hp"]
	if data.has("ap"):
		ap = data["ap"]
	if data.has("mp"):
		mp = data["mp"]
	if data.has("xp"):
		xp = data["xp"]
	if data.has("xp_to_level_up"):
		xp_to_level_up = data["xp_to_level_up"]
	if data.has("atk"):
		atk = data["atk"]
	if data.has("points"):
		points = data["points"]
	if data.has("key"):
		key = data["key"]
	if data.has("weapons"):
		for weapon in data["weapons"]:
			set_weapon(weapon)
	if data.has("inventory"):
		for item in data["inventory"]:
			set_inventory_item(item)
	if data.has("relics"):
		for relic in data["relics"]:
			set_relic_item(relic)
	if data.has("base_speed"):
		base_speed = data["base_speed"]
	if data.has("equiped_item"):
		equiped_item = data["equiped_item"]
		set_equiped_item(equiped_item[0], 0)
		set_equiped_item(equiped_item[1], 1)
	if data.has("dash_unlocked"):
		dash_unlocked = data["dash_unlocked"]
	if data.has("neck_of_protection"):
		neck_of_protection = data["neck_of_protection"]
	if data.has("ring_of_souls"):
		ring_of_souls = data["ring_of_souls"]
	if data.has("armor_of_light"):
		armor_of_light = data["armor_of_light"]
