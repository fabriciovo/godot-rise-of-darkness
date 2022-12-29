extends "res://Assets/Buttons/ActionButton.gd"

const Slash = preload("res://Assets/Animations/Slash.tscn")

func _on_pressed():
	var main = get_tree().current_scene
	var enemy = BattleUnits.Enemy
	var playerStats = BattleUnits.PlayerStats
	var playerAim = main.get_node("PlayerAim")
	
	if enemy and playerStats:
		if playerAim.area_name == "Critical_Area":
			create_slash(enemy.global_position)
			enemy.take_damage(20)
			playerStats.mp -= 1
			playerStats.ap -= 1
		elif "Hit" in playerAim.area_name:
			create_slash(enemy.global_position)
			enemy.take_damage(6)
			playerStats.mp -= 1
			playerStats.ap -= 1
		else:
			playerStats.ap -= 2
			playerStats.mp -= 2
		playerAim.active = false
		playerAim.visible = false
		
		
func create_slash(position):
	var slash = Slash.instance()
	var main = get_tree().current_scene
	main.add_child(slash)
	slash.global_position = position
