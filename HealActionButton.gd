extends "res://ActionButton.gd"


func _on_pressed():
	var player = BattleUnits.PlayerStats
	
	if player:
		if player.mp >= 5:
			player.hp += 3
			player.mp -= 5
			player.ap -= 1
	

