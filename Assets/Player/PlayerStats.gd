extends Node

const BattleUnits = preload("res://Assets/Battle/BattleUnits.tres")

var hp = PlayerControll.hp setget set_hp
var ap = PlayerControll.ap setget set_ap
var mp = PlayerControll.mp setget set_mp
var items = PlayerControll.items

signal hp_changed(value)
signal ap_changed(value)
signal mp_changed(value)

signal end_turn

func set_hp(value):
	hp = clamp(value, 0 , PlayerControll.max_hp)
	PlayerControll.set_hp(hp)
	emit_signal("hp_changed", hp)

func set_ap(value):
	ap = clamp(value, 0 , PlayerControll.max_ap)
	PlayerControll.set_ap(ap)
	emit_signal("ap_changed", ap)
	if ap == 0:
		emit_signal("end_turn")

func set_mp(value):
	mp = min(value, PlayerControll.max_mp)
	PlayerControll.set_mp(mp)
	emit_signal("mp_changed", mp)

func _ready():
	BattleUnits.PlayerStats = self

func _exit_tree():
	BattleUnits.PlayerStats = null


