class_name Enemy
extends Node2D

const BattleUnits = preload("res://Assets/Battle/BattleUnits.tres")
var smoke = preload("res://Assets/Animations/smoke.tscn").instance()

onready var array_areas = get_node("Areas")
var hp = Global.enemy_battle_unit_hp setget set_hp 
var damage = Global.enemy_battle_unit_damage
var type = Global.enemy_battle_unit_type
onready var hpLabel = $HPLabel
onready var animationPlayer = $AnimationPlayer



signal died
signal end_turn

func set_hp(new_hp):
	hp = new_hp
	if hpLabel != null:
		hpLabel.text = str(hp) + "hp"

func _ready():
	basic_animation()
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
	basic_animation()


	
func take_damage(amount):
	self.hp -= amount
	if is_dead():
		$Sprite.visible = false
		emit_signal("died")
		add_child(smoke)
		smoke.get_node("Sprite").scale = Vector2(3,3)
		yield(smoke.get_node("AnimationPlayer"),"animation_finished")
		queue_free()
	else:
		animationPlayer.play("Shake")
		yield(animationPlayer,"animation_finished")
		basic_animation()


func is_dead():
	return hp <= 0


func basic_animation():
		match type:
			"bat":
				animationPlayer.play("Bat_anim")
