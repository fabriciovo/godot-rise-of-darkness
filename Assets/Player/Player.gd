class_name Player
extends KinematicBody2D

onready var action_area = $ActionArea
onready var action_sprite =  $ActionArea/action
onready var action_collision =  $ActionArea/AreaCollision
onready var actionArea = $ActionArea

var damageText = preload("res://Assets/UI/DamageText.tscn")
var hp = PlayerControll.hp setget set_hp
var ap = PlayerControll.ap setget set_ap
var mp = PlayerControll.mp setget set_mp
var items = PlayerControll.items
var key = PlayerControll.key

var knockback = Vector2.ZERO

func set_hp(value):
	hp = clamp(value, 0 , PlayerControll.max_hp)
	PlayerControll.set_hp(hp)

func set_ap(value):
	ap = clamp(value, 0 , PlayerControll.max_ap)
	PlayerControll.set_ap(ap)

func set_mp(value):
	mp = min(value, PlayerControll.max_mp)
	PlayerControll.set_mp(mp)

signal change_scene(target_scene, value)

var dir = "right"
var speed = 30
var velocity = Vector2.ZERO
var action_state = false
var hit = false
var can_execute_action = false
var heal = false
func _ready():
	add_to_group(Global.GROUPS.PLAYER)
	action_collision.disabled = true
	action_area.visible = false
	actionArea.knockback_vector = Vector2.LEFT
	$AP_Timer.start(1)

func get_input():
	movement()
	execute_action()
	change_action_area_direction()

func action(value):
	if ap > 0 and value != -1:
		$AP_Timer.start(.8)
		match PlayerControll.equiped_item[value]:
			Global.WEAPONS.SWORD:
				create_sword(value)
			Global.WEAPONS.BOW:
				if mp >= 1:
					create_arrow()
					set_mp(mp-1)
			Global.WEAPONS.BOMB:
				if mp >= 3:
					create_bomb()
					set_mp(mp-3)
			Global.WEAPONS.HEAL: 
				if mp >= 5:
					heal()
					set_mp(mp-5)
		match dir:
			"right":
				$PlayerAnimation.play("action_right")
				yield($PlayerAnimation, "animation_finished")
				pass
			"left":
				$PlayerAnimation.play("action_left")
				yield($PlayerAnimation, "animation_finished")
				pass
			"up":
				$PlayerAnimation.play("action_up")
				yield($PlayerAnimation, "animation_finished")
				pass
			"down":
				$PlayerAnimation.play("action_down")
				yield($PlayerAnimation, "animation_finished")
				pass
		action_area.visible = false
		action_state = false
		action_collision.disabled = true

func _physics_process(delta):
	if not hit:
		get_input()
		velocity = move_and_slide(velocity)

func _process(delta):
	if(!Global.stop):
		set_physics_process(true)
	else:
		set_physics_process(false)

func _on_PlayerBody_body_entered(body):
	if body.is_in_group(Global.GROUPS.ENEMY):
		damage(body.battle_unit_damage)
	if body.is_in_group(Global.GROUPS.DOOR):
		Global.doorName = body.door_name
		get_tree().change_scene(body.target_scene)

func _on_ActionArea_body_entered(body):
	if body.is_in_group(Global.GROUPS.BOX): 
		body.Destroy()

func create_sword(value):
	set_ap(ap-1)
	action_state = true
	action_area.visible = true
	action_area.get_node("action").visible = true
	action_area.get_node("action").get_node("AnimationPlayer").play("Slash_anim")
	action_collision.disabled = false
	action_sprite.frame = PlayerControll.equiped_item[value]

func create_bomb():
		set_ap(ap-1)
		var bomb_object = preload("res://Assets/Enviroment/Bomb_Object.tscn").instance()
		bomb_object.global_position = global_position
		get_tree().get_current_scene().add_child(bomb_object)

func create_arrow():
		set_ap(ap-1)
		var arrow_object = preload("res://Assets/Enviroment/Arrow_Object.tscn").instance()
		arrow_object.global_position = global_position
		match dir:
			"right":
				arrow_object.direction = Vector2.RIGHT
				arrow_object.frame = 23
			"left":
				arrow_object.direction = Vector2.LEFT
				arrow_object.frame = 21
			"up":
				arrow_object.direction = Vector2.UP
				arrow_object.frame = 22
			"down":
				arrow_object.direction = Vector2.DOWN
				arrow_object.frame = 20
		get_tree().get_current_scene().add_child(arrow_object)

func heal():
	set_ap(0)
	set_hp(hp+10)

func knockback():
	pass

func damage(value):
	var text = damageText.instance()
	text.set_text(str(value))
	add_child(text)
	$PlayerAnimation.stop()
	hit = true
	set_hp(hp-value)
	$PlayerAnimation.play("damage_anim")
	yield($PlayerAnimation, "animation_finished")
	hit = false
	
func recover_mana():
	set_mp(PlayerControll.max_mp)


func _on_AP_Timer_timeout():
	set_ap(ap+1)

func change_action_area_direction():
	if dir == "right":
		action_area.get_node("action").rotation_degrees = 0
		action_area.get_node("action").flip_h = false
		action_area.position.x = 10
		action_area.position.y = 2

	elif dir == "left":
		action_area.get_node("action").rotation_degrees = 0
		action_area.get_node("action").flip_h = true
		action_area.position.x = -12
		action_area.position.y = 2

	elif dir == "up":
		action_area.get_node("action").flip_h = true
		action_area.get_node("action").rotation_degrees = 90
		action_area.position.x = 2
		action_area.position.y = -12

	elif dir == "down":
		action_area.get_node("action").flip_h = true
		action_area.get_node("action").rotation_degrees = -90
		action_area.position.x = -3
		action_area.position.y = 14


func execute_action():
	if can_execute_action:
		if Input.is_action_just_pressed("action_1"):
			if PlayerControll.equiped_item[0] != -1:
				action(0)
		elif Input.is_action_just_pressed("action_2"):
			if PlayerControll.equiped_item[1] != -1:
				action(1)

func movement(): 
	velocity = Vector2.ZERO
	if !action_state:
		if Input.is_action_pressed('ui_right'):
			$PlayerAnimation.play("walk_right")
			velocity.x += 1
			dir = "right"
			actionArea.knockback_vector = velocity
		elif Input.is_action_pressed('ui_left'):
			velocity.x -= 1
			$PlayerAnimation.play("walk_left")
			dir = "left"
			actionArea.knockback_vector = velocity
		elif Input.is_action_pressed('ui_down'):
			velocity.y += 1
			$PlayerAnimation.play("walk_down")
			dir = "down"
			actionArea.knockback_vector = velocity
		elif Input.is_action_pressed('ui_up'):
			velocity.y -= 1
			$PlayerAnimation.play("walk_up")
			dir = "up"
			actionArea.knockback_vector = velocity
		else:
			$PlayerAnimation.stop()
		velocity = velocity.normalized() * speed

func _on_Floor_mouse_entered():
	can_execute_action = true

func _on_Floor_mouse_exited():
	can_execute_action = false
