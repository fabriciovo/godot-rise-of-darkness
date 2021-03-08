extends Node

const BattleUnits = preload("res://BattleUnits.tres")
onready var battleActionButtons = $UI/BattleActionButtons





func _ready():
	start_player_turn()


func start_enemy_turn():
	var enemy = BattleUnits.Enemy
	battleActionButtons.hide()
	if enemy != null:
		enemy.attack()
		yield(enemy, "end_turn")
	start_player_turn()
	
func start_player_turn():
	var playerStats = BattleUnits.PlayerStats
	battleActionButtons.show()
	playerStats.ap = playerStats.max_ap
	yield(playerStats, "end_turn")
	start_enemy_turn()



func _on_Enemy_died():
	battleActionButtons.hide()




