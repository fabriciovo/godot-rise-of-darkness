extends "res://ActionButton.gd"

const Slash = preload("res://Slash.tscn")

func _on_pressed():

	var enemy = BattleUnits.Enemy
	var playerStats = BattleUnits.PlayerStats
	
	if enemy and playerStats:
		create_slash(enemy.global_position)
		enemy.take_damage(4)
		playerStats.ap -= 1
		playerStats.mp += 2
		
func create_slash(position):
	var slash = Slash.instance()
	var main = get_tree().current_scene
	main.add_child(slash)
	slash.global_position = position
