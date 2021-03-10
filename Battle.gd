extends Node

export (Array, PackedScene) var enemies = []

const BattleUnits = preload("res://BattleUnits.tres")
onready var battleActionButtons = $UI/BattleActionButtons
onready var animationPlayer = $AnimationPlayer
onready var nextRoomButton = $UI/CenterContainer/NextRoomButton	
onready var startPosition = $EnemyPostion



func _ready():
	start_player_turn()
	nextRoomButton.hide()
	var enemy = BattleUnits.Enemy
	if enemy: 
		enemy.connect("died",self,"_on_Enemy_died")


func start_enemy_turn():
	var enemy = BattleUnits.Enemy
	battleActionButtons.hide()
	if enemy != null and not enemy.is_queued_for_deletion():
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
	nextRoomButton.show()

func create_new_enemy():
	enemies.shuffle()
	var Enemy = enemies.front()
	var enemy = Enemy.instance()
	startPosition.add_child(enemy) 
	enemy.connect("died", self, "_on_Enemy_died")
	


func _on_NextRoomButton_pressed():
	nextRoomButton.hide()
	animationPlayer.play("FadeToNewRoom")
	yield(animationPlayer, "animation_finished")
	battleActionButtons.show()
	var playerStats = BattleUnits.PlayerStats
	playerStats.ap = playerStats.max_ap
	create_new_enemy()
	
