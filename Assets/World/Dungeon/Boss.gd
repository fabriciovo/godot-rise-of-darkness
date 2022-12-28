extends KinematicBody2D
onready var frame = $Sprite.frame

const battle_unit_damage = 5
const battle_unit_hp = 300
const battle_unit_type = "boss"
var ID = name
func _ready():
	add_to_group(Global.GROUPS.ENEMY)
	$BossAnimation.play("boss_start_anim")

