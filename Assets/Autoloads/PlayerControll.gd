extends Node

var max_hp = 25 
var max_ap = 3
var max_mp = 10 
var hp = max_hp setget set_hp
var ap = max_ap setget set_ap
var mp = max_mp setget set_mp
var xp = 0 setget set_xp 
var xp_to_level_up = 100 setget set_xp_to_level_up
var level = 1 setget set_level
var atk = 2 setget set_atk
var points = 0 setget set_points
var items = [] setget set_item
var equiped_item = [-1,-1] 
var key = 0


func increase_max_hp():
	points-=1
	max_hp += 1
	hp = max_hp

func increase_max_mp():
	points-=1
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
		get_tree().change_scene("res://Assets/GameOver/Game_Over.tscn")

func set_ap(value):
	ap = clamp(value, 0 , max_ap)

func set_mp(value):
	mp = min(value, max_mp)

func set_item(value):
	items.push_front(value)

func set_equiped_item(value, slot):
	equiped_item[slot] = value

func set_key(value):
	key = value

func set_xp(value):
	xp += value
	if xp >= xp_to_level_up:
		points = level + 2
		level+=1
		xp_to_level_up = floor(xp_to_level_up * 1.2)
		xp =  xp_to_level_up - xp

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
