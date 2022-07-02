class_name Player
extends KinematicBody2D

onready var action_area = $ActionArea
onready var action_sprite =  $ActionArea/action
onready var action_collision =  $ActionArea/AreaCollision
onready var actionArea = $ActionArea

var hp = PlayerControll.hp setget set_hp
var ap = PlayerControll.ap setget set_ap
var mp = PlayerControll.mp setget set_mp
var items = PlayerControll.items

func set_hp(value):
	hp = clamp(value, 0 , PlayerControll.max_hp)
	PlayerControll.set_hp(hp)

func set_ap(value):
	ap = clamp(value, 0 , PlayerControll.max_ap)
	PlayerControll.set_ap(ap)

func set_mp(value):
	mp = min(value, PlayerControll.max_mp)
	PlayerControll.set_mp(mp)


signal encounter(enemy)
signal change_scene(target_scene, value)

var dir = "right"
var speed = 30
var velocity = Vector2.ZERO
var action_state = false
var hit = false

func _ready():
	add_to_group(Global.GROUPS.PLAYER)
	action_collision.disabled = true
	action_area.visible = false
	actionArea.knockback_vector = Vector2.LEFT
	if ap < 3:
		$AP_Timer.start(1)

func get_input():
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
		
	if Input.is_action_just_pressed("action_1"):
		if PlayerControll.equiped_item[0] != -1:
			action(0)
	elif Input.is_action_just_pressed("action_2"):
		if PlayerControll.equiped_item[1] != -1:
			action(1)
			
	if dir == "right":
		action_area.position.x = 10
		action_area.position.y = 2
	elif dir == "left":
		action_area.position.x = -8
		action_area.position.y = 2
	elif dir == "up":
		action_area.position.y = -8
		action_area.position.x = 1
	elif dir == "down":
		action_area.position.y = 10
		action_area.position.x = 1

func action(value):
	if ap > 0:
		$AP_Timer.start(1)
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
					set_hp(mp-5)
		if dir == "right":
			$PlayerAnimation.play("action_right")
			yield($PlayerAnimation, "animation_finished")
		elif dir == "left":
			$PlayerAnimation.play("action_left")
			yield($PlayerAnimation, "animation_finished")
		elif dir == "up":
			$PlayerAnimation.play("action_up")
			yield($PlayerAnimation, "animation_finished")
		elif dir == "down":
			$PlayerAnimation.play("action_down")
			yield($PlayerAnimation, "animation_finished")



	action_area.visible = false
	action_state = false
	action_collision.disabled = true



func _physics_process(delta):
	if not hit:
		get_input()
		velocity = move_and_slide(velocity)


func _on_PlayerBody_body_entered(body):
	if body.is_in_group(Global.GROUPS.ENEMY):
		#emit_signal("encounter", body)
		Global.last_enemy = body.ID
		Global.enemy_battle_unit_damage = body.battle_unit_damage
		Global.enemy_battle_unit_hp = body.battle_unit_hp
		Global.enemy_battle_unit_type = body.battle_unit_type
		Global.enemy_frame = body.frame
		Global.player_last_position = global_position
		Global.player_last_scene = get_tree().current_scene.filename
		get_parent().get_node("Transition").fade_in()

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
	pass
#		var arrow_object = preload("res://Assets/Enviroment/Bomb_Object.tscn").instance()
#		arrow_object.global_position = global_position
#		get_tree().get_current_scene().add_child(arrow_object)

func damage():
	$PlayerAnimation.stop()
	hit = true
	set_hp(hp-3)
	$PlayerAnimation.play("damage_anim")
	yield($PlayerAnimation, "animation_finished")
	hit = false
	
func recover_mana():
	set_mp(PlayerControll.max_mp)


func _on_AP_Timer_timeout():
	set_ap(ap+1)



