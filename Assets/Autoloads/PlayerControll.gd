extends Node

var max_hp = 25
var max_ap = 3
var max_mp = 10
var hp = max_hp setget set_hp
var ap = max_ap setget set_ap
var mp = max_mp setget set_mp
var items = [] setget set_item
var equiped_item = [-1,-1] 


func set_hp(value):
	hp = clamp(value, 0 , max_hp)

func set_ap(value):
	ap = clamp(value, 0 , max_ap)

func set_mp(value):
	mp = min(value, max_mp)

func set_item(value):
	items.push_front(value)

func set_equiped_item(value, slot):
	equiped_item[slot] = value
	print(equiped_item)



