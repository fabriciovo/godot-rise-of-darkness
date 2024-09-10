class_name World_Dragon_Boss extends World_Enemy

onready var player = get_tree().current_scene.get_node("Player")
onready var stop_timer = $Stop_Timer
var direction = Vector2(-20, 20)
var velocity = Vector2(20,20)
var dir_frame_open_eye = [9,10,11,12]
var dir_frame_closed_eye = [14,15,16,17,9]
var dir_frame = 0
var can_take_damage = false
var collision
var action_timer = 4
var boss_fight_node

func _ready():
	get_tree().current_scene.start_shake(10, 1)
	ID = name
	battle_unit_max_hp = 300
	battle_unit_xp = 0
	battle_unit_damage = 3
	battle_unit_hp = battle_unit_max_hp
	const_speed = 11
	speed = const_speed
	add_to_group(Global.GROUPS.ENEMY)
	start_shooter()
	boss_fight_node = get_tree().current_scene.get_node("boss_fight")

func _physics_process(_delta):
	if not player: return
	if not hit:
		var dir = (player.global_position - global_position).normalized()
		dir = move_and_collide(dir * speed * _delta)
	knockback = knockback.move_toward(Vector2.ZERO, speed * _delta)
	knockback = move_and_slide(knockback / 1.1) 

func action():
	stop_timer.start(1)
	speed = 0
	var attack = preload("res://Assets/Enemy/World Enemy/enemy_projectile.tscn").instance()
	attack.damage = 5
	attack.global_position = global_position
	attack.speed = 80
	get_tree().get_current_scene().add_child(attack)
	$Shoot_Timer.start(action_timer)

func Destroy():
	Global.dead_enemies.push_front(ID)
	PlayerControll.set_xp(battle_unit_xp)
	Disable()
	var _inst_smoke = smoke.instance()
	_inst_smoke.position = position
	get_tree().current_scene.add_child(_inst_smoke)
#	var win_item = preload("res://Assets/WinScene/Win_Item.tscn").instance()
#	win_item.global_position = global_position
#	get_tree().get_current_scene().add_child(win_item)
	SoundController.play_effect(SoundController.EFFECTS.enemy_die)
	boss_fight_node.dragon_death()
	queue_free()

func _on_Shoot_Timer_timeout():
	action()

func start_shooter():
	$Shoot_Timer.start(action_timer)

func _on_Stop_Timer_timeout():
	speed = const_speed
