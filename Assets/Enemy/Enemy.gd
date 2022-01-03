extends Node2D

const BattleUnits = preload("res://Assets/Battle/BattleUnits.tres")

var hp = Global.enemy_battle_unit_hp setget set_hp 
var damage = Global.enemy_battle_unit_damage

onready var hpLabel = $HPLabel
onready var animationPlayer = $AnimationPlayer

signal died
signal end_turn

func set_hp(new_hp):
	hp = new_hp
	if hpLabel != null:
		hpLabel.text = str(hp) + "hp"

func _ready():
	hp = Global.enemy_battle_unit_hp
	damage = Global.enemy_battle_unit_damage
	$Sprite.frame = Global.enemy_frame
	hpLabel.text = str(hp) + "hp"
	BattleUnits.Enemy = self
func _exit_tree():
	BattleUnits.Enemy = null

func attack() -> void:
	yield (get_tree().create_timer(0.4), "timeout")
	animationPlayer.play("Attack")
	yield(animationPlayer,"animation_finished")
	BattleUnits.PlayerStats.hp -= damage
	emit_signal("end_turn")
	
func take_damage(amount):
	self.hp -= amount
	if is_dead():
		emit_signal("died")
		queue_free()
	else:
		animationPlayer.play("Shake")


func is_dead():
	return hp <= 0
