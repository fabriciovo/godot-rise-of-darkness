class_name World_Enemy extends KinematicBody2D

var ID = name
onready var frame = $Sprite.frame
onready var timer = $Timer

var battle_unit_xp = 50
var battle_unit_max_hp = 10
var battle_unit_damage = 0
var battle_unit_hp = battle_unit_max_hp

var smoke = preload("res://Assets/Animations/smoke.tscn")
var damageText = preload("res://Assets/UI/FloatText.tscn")
var knockback = Vector2.ZERO
var hits = 1
var hit = false
var speed = 10
var const_speed = 0
var quest_key = ""

func _ready():
	add_to_group(Global.GROUPS.ENEMY)
	Enable()

func _process(_delta):
	if(!Global.stop):
		set_physics_process(true)
	else:
		set_physics_process(false)

func _on_Timer_timeout():
	hit = false
	Enable()

func Destroy():
	Global.dead_enemies.push_front(ID)
	PlayerControll.set_xp(battle_unit_xp)
	Disable()
	var temp_smoke = smoke.instance()
	add_child(temp_smoke)
	SoundController.play_effect(SoundController.EFFECTS.enemy_die)
	yield(temp_smoke.get_node("AnimationPlayer"),"animation_finished")
	queue_free()

func damage(_knockbackValue, _damageValue):
		SoundController.play_effect(SoundController.EFFECTS.enemy_hit)
		knockback = _knockbackValue
		var text = damageText.instance()
		text.set_text(str(_damageValue))
		add_child(text)
		hit = true
		battle_unit_hp -= _damageValue
		hits+=1
		$Enemy_Animation.play("damage_anim")
		yield($Enemy_Animation, "animation_finished")
		if battle_unit_hp <= 0:
			if quest_key != "":
				Global.QUESTS[quest_key].Progress += 1
			Destroy()
		else:
			timer.start(1)

func _on_Area_area_entered(area):
	if area.is_in_group(Global.GROUPS.SWORD) and not hit:
		knockback = area.knockback_vector * 120
		damage(knockback,  PlayerControll.atk)
	if area.is_in_group(Global.GROUPS.SHIELD) and not hit:
		knockback = area.knockback_vector * 120
		damage(knockback, 0)
func _on_Area_body_entered(body):
	if body.is_in_group(Global.GROUPS.ARROW) and not hit:
		damage(knockback,  PlayerControll.atk+1)
		body.queue_free()
	if body.is_in_group(Global.GROUPS.BOMB) and not hit:
		knockback = -global_position
		damage(knockback,  PlayerControll.atk+5)
	if body.is_in_group(Global.GROUPS.SHIELD) and not hit:
		knockback = -global_position
		damage(knockback,  0)

func Disable():
	speed = 0
	$Sprite.visible = false
	set_physics_process(false);
	
func Enable():
	speed = const_speed
	set_physics_process(true);
