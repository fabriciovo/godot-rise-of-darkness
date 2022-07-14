extends Node

export (Array, PackedScene) var enemies = []

const BattleUnits = preload("res://Assets/Battle/BattleUnits.tres")
onready var battleActionButtons = $UI/BattleActionButtons
onready var animationPlayer = $AnimationPlayer
onready var nextRoomButton = $UI/CenterContainer/NextRoomButton	
onready var startPosition = $EnemyPostion

onready var transition = $Transition/Transition_Animator

func _ready():
	transition.play("fade_out_anim")
	yield(transition,"animation_finished")
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
	playerStats.set_ap(PlayerControll.max_ap)
	battleActionButtons.show()
	yield(playerStats, "end_turn")
	start_enemy_turn()

func _on_Enemy_died():
	battleActionButtons.hide()
	nextRoomButton.show()
	Global.dead_enemies.push_front(Global.last_enemy)

func _on_NextRoomButton_pressed():
	nextRoomButton.hide()
	transition.play("fade_in_anim")
	yield(transition, "animation_finished")
	battleActionButtons.show()
	var playerStats = BattleUnits.PlayerStats
	playerStats.ap = PlayerControll.max_mp
	get_tree().change_scene(Global.player_last_scene)

