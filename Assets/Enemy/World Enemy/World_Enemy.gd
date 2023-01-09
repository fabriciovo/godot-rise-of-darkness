class_name World_Enemy
extends KinematicBody2D

var ID = name
onready var frame = $Sprite.frame
onready var timer = $Timer

var battle_unit_max_hp = 10
var battle_unit_type = "enemy"
var battle_unit_damage = 0
var battle_unit_hp = battle_unit_max_hp

var smoke = preload("res://Assets/Animations/smoke.tscn").instance()
var damageText = preload("res://Assets/UI/DamageText.tscn")
var knockback = Vector2.ZERO
var hits = 1
var hit = false
var speed = 10
var const_speed = 0
var normal_speed = speed


func _ready():
	add_to_group(Global.GROUPS.ENEMY)
	Enable()


func _process(delta):
	if(!Global.stop):
		set_physics_process(true)
	else:
		set_physics_process(false)


func _on_Timer_timeout():
	hit = false


func Destroy():
	Global.dead_enemies.push_front(ID)
	PlayerControll.set_xp(battle_unit_max_hp/2)
	Disable()
	add_child(smoke)
	yield(smoke.get_node("AnimationPlayer"),"animation_finished")
	queue_free()

func damage():
		var text = damageText.instance()
		text.set_text(str(PlayerControll.atk))
		add_child(text)
		hit = true
		$Enemy_Animation.play("damage_anim")
		yield($Enemy_Animation, "animation_finished")
		battle_unit_hp -= PlayerControll.atk
		hits+=1
		if battle_unit_hp <= 0:
			Destroy()
		else:
			timer.start(1)

func _on_Area_area_entered(area):
	if area.is_in_group(Global.GROUPS.SWORD) and not hit:
		knockback = area.knockback_vector * 120
		damage()

func _on_Area_body_entered(body):
	if body.is_in_group(Global.GROUPS.ARROW) and not hit:
		knockback = body.knockback_vector * 120
		body.queue_free()
		damage()
	if body.is_in_group(Global.GROUPS.BOMB) and not hit:
		knockback = -global_position
		damage()

func Disable():
	speed = 0
	$Sprite.visible = false
	set_physics_process(false);

func Enable():
	set_physics_process(true);
	speed = normal_speed
