extends World_Enemy

onready var anim = $AnimationPlayer
onready var sprite = $Sprite
onready var text_box = $Text_Box_Layer/Text_Box

var direction = Vector2.ZERO
var projectile = preload("res://Assets/Enemy/World Enemy/enemy_projectile.tscn")
var attacking = false

func _ready():
	battle_unit_max_hp = 100
	battle_unit_damage = 10
	battle_unit_hp = battle_unit_max_hp 
	add_to_group(Global.GROUPS.ENEMY)
	const_speed = 20
	direction.x = const_speed
	$Attack_Timer.start(4)

func _physics_process(_delta):
	if Global.stop or Global.cutscene: return
	if attacking: return
	if hit: return
	var collision = move_and_collide(direction * _delta)
	if collision:
		direction = direction.bounce(collision.normal)
	direction.y = 0
	if direction.x >= 1:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
	if direction.x != 0:
		anim.play("sides")

func _on_Timer_timeout():
	hit = false
	timer.stop()


func _on_Attack_Timer_timeout():
	$Attack_Timer.start(4)
	if Global.stop or Global.cutscene: return
	var attack = projectile.instance()
	attack.global_position = global_position
	direction.x = 0
	attacking = true
	anim.play("attack_anim")
	get_tree().get_current_scene().add_child(attack)
	yield(anim, "animation_finished")
	attacking = false
	direction.x = const_speed

func _on_Area_body_entered(body):
	if body.is_in_group(Global.GROUPS.ARROW):
		damage(1, PlayerControll.atk+1)
		body.queue_free()

func Destroy():
	SoundController.stop_music()
	spr.visible = false
	var temp_smoke = smoke.instance()
	add_child(temp_smoke)
	SoundController.play_effect(SoundController.EFFECTS.enemy_die)
	yield(temp_smoke.get_node("AnimationPlayer"),"animation_finished")
	SoundController.play_effect(SoundController.EFFECTS.positive_10)
	Global.dead_enemies.push_front({"id": ID, "soul": has_soul})
	Global.cutscene = true
	text_box.dialog_name = "necromancer_death.json"
	text_box.start_dialog()


func _on_Text_Box_on_end_dialog():
	SoundController.play_music(SoundController.MUSIC.dungeon)
	Global.stop = false
	Global.cutscene = false
	Global.dark_mages.necromancer = true
	Global.QUESTS["DEFEAT_DARK_MAGES"].Progress+=1
	queue_free()
