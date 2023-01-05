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
var items = [-1,-1] setget set_item
var equiped_item = [-1,-1] 
var key = 0


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
		level+=1
		xp_to_level_up = xp_to_level_up * 1.2
		xp =  xp_to_level_up - xp

func set_level(value):
	level = value

func set_xp_to_level_up(value):
	xp_to_level_up = value

func set_atk(value):
	atk = value

func restart():
	set_hp(max_hp)
	set_mp(max_mp)
	set_ap(max_ap)
