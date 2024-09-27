class_name Player
extends KinematicBody2D

onready var action_area = $Action_Area
onready var shield_area = $Shield_Area
onready var shield_area_collision = $Shield_Area/Shield_Area_Collision
onready var shield_area_sprite = $Shield_Area/Shield_Sprite
onready var action_sprite =  $Action_Area/action
onready var action_collision =  $Action_Area/AreaCollision

onready var neck_of_protection = preload("res://Assets/Relics/Neck_Of_Protection.tscn").instance()

var weapons_texuture = preload("res://Sprites/Get_Weapon_Icons.png")
var relics_texuture = preload("res://Sprites/Get_Relic_Icons.png")

var damage_text = preload("res://Assets/UI/FloatText.tscn")
var float_text = preload("res://Assets/UI/FloatText.tscn")
var hp = PlayerControll.hp setget set_hp
var ap = PlayerControll.ap setget set_ap
var mp = PlayerControll.mp setget set_mp
var weapons = PlayerControll.weapons
var key = PlayerControll.key
var get_item_frame = 0
var get_item_anim = false
var enemiesBody = []
var casting = false

var speed = PlayerControll.base_speed
var knockback = Vector2.ZERO
var is_shield_up

func set_hp(value):
	hp = clamp(value, 0 , PlayerControll.max_hp)
	PlayerControll.set_hp(hp)

func set_ap(value):
	ap = clamp(value, 0 , PlayerControll.max_ap)
	PlayerControll.set_ap(ap)

func set_mp(value):
	mp = min(value, PlayerControll.max_mp)
	PlayerControll.set_mp(mp)

func add_mp(_value):
	mp += min(_value, PlayerControll.max_mp)
	PlayerControll.set_mp(mp)
	var _text = float_text.instance()
	_text.set_text("MP +" + str(_value))
	add_child(_text)

var dir = "right"
var velocity = Vector2.ZERO
var action_state = false
var hit = false
var dashing = false
var invincible = false

func _ready():
	add_to_group(Global.GROUPS.PLAYER)
	action_collision.disabled = true
	action_area.visible = false
	shield_area.visible = false
	shield_area_collision.disabled = true
	action_area.knockback_vector = Vector2.LEFT
	$AP_Timer.start(1)
	set_collision_layer_bit(0, true)
	set_collision_mask_bit(0, true)
	set_collision_layer_bit(7, false)
	set_collision_mask_bit(7, false)
	if PlayerControll.neck_of_protection:
		add_child(neck_of_protection)
		is_shield_up = true


func get_input():
	if Global.stop: return
	movement()
	execute_action()
	change_action_area_direction()

func action(_value):
	if casting: return
	if ap > 0 and _value != -1:
		$AP_Timer.start(.8)
		if  Global.WEAPONS.SWORD == _value:
			create_sword(_value)
		elif Global.WEAPONS.BOW  == _value:
				if ap >= 1 and mp >= 1:
					create_arrow()
		elif Global.WEAPONS.BOMB  == _value:
				if mp >= 3:
					create_bomb()
					set_mp(mp-3)
					var text = float_text.instance()
					text.set_text("MP -3")
					add_child(text)
		elif Global.WEAPONS.HEAL == _value: 
				if mp >= 3 and hp < PlayerControll.max_hp:
					get_item_frame = 3 
					casting = true
					action_state = true
					$PlayerAnimation.play("use_magic")
					yield($PlayerAnimation, "animation_finished")
					if casting:
						var textMP = float_text.instance()
						var textHP = float_text.instance()
						textMP.set_text("MP -3")
						add_child(textMP)
						textHP.set_text("HP +5")
						textHP.get_position_in_parent()
						textHP.pos.x = -52
						add_child(textHP)
						heal()
						set_mp(mp-3)
						casting = false
		elif Global.WEAPONS.SHIELD == _value:
			create_shield()
			
		match dir:
			"right":
				$PlayerAnimation.play("action_right")
				yield($PlayerAnimation, "animation_finished")
			"left":
				$PlayerAnimation.play("action_left")
				yield($PlayerAnimation, "animation_finished")
			"up":
				$PlayerAnimation.play("action_up")
				yield($PlayerAnimation, "animation_finished")
			"down":
				$PlayerAnimation.play("action_down")
				yield($PlayerAnimation, "animation_finished")
		action_area.visible = false
		shield_area.visible = false
		action_state = false
		action_collision.disabled = true
		shield_area_collision.disabled = true

func _physics_process(_delta):
	if PlayerControll.dead: return
	if get_item_anim: return
	if hit: return
	get_input()
	velocity = move_and_slide(velocity)

func _process(_delta):
	if PlayerControll.dead:
		$PlayerAnimation.play("death")
		SoundController.stop_music()
		Global.stop = true
		yield($PlayerAnimation,"animation_finished")
		var _chnage_scene = get_tree().change_scene("res://Assets/GameOver/Game_Over.tscn")
	if get_item_anim: return
	if(!Global.stop):
		set_physics_process(true)
		take_damage_by_enemies()
	else:
		set_physics_process(false)

func take_damage_by_enemies():
#	for i in enemiesBody.size():
#			damage(enemiesBody[i].battle_unit_damage)
	pass

func _on_PlayerBody_body_entered(_body):
	check_projectile_collision(_body)
	if _body.is_in_group(Global.GROUPS.ENEMY):
		damage(_body.battle_unit_damage)
	if _body.is_in_group(Global.GROUPS.DOOR):
		var scene_instance = get_tree().change_scene(_body.target_scene)
		if scene_instance == OK: 
				Global.door_name = _body.door_name
	if _body.is_in_group(Global.GROUPS.DOOR_WITH_INTERACTION):
		if not _body.can_pass:
			_body.trigger_dialog_box()

func _on_PlayerBody_body_exited(_body):
#	if _body.is_in_group(Global.GROUPS.ENEMY):
#		enemiesBody.erase(_body)
	pass

func _on_ActionArea_body_entered(_body):
	if _body.is_in_group(Global.GROUPS.BOX): 
		_body.Destroy()

func create_sword(_value):
	if action_state: return
	if PlayerControll.souls_quest_completed and hp == PlayerControll.max_hp:
		create_sword_projectile()
	set_ap(ap-1)
	action_state = true
	action_area.visible = true
	action_area.get_node("action").visible = true
	var _action_area_anim = action_area.get_node("action").get_node("AnimationPlayer")
	_action_area_anim.play("Slash_anim")
	action_collision.disabled = false
	SoundController.play_effect_with_random_pitch(SoundController.EFFECTS.sword_slash, 1.4)
	action_sprite.frame = PlayerControll.equiped_item[_value]
	yield(_action_area_anim, "animation_finished")


func create_sword_projectile():
	var _inst = preload("res://Assets/Player/Hero_Projectile.tscn").instance()
	_inst.global_position = action_area.global_position
	match dir:
		"right":
			_inst.direction = Vector2.RIGHT
		"left":
			_inst.direction = Vector2.LEFT
		"up":
			_inst.direction = Vector2.UP
		"down":
			_inst.direction = Vector2.DOWN
	get_tree().get_current_scene().add_child(_inst)

func create_shield(): 
	action_state = true
	shield_area.visible = true
	shield_area_collision.disabled = false
	shield_area.get_node("Shield_Sprite").visible = true

func create_bomb():
	set_ap(ap-1)
	var bomb_object = preload("res://Assets/Enviroment/Bomb_Object.tscn").instance()
	bomb_object.global_position = global_position
	get_tree().get_current_scene().add_child(bomb_object)

func create_arrow():
	set_ap(ap-2)
	set_mp(mp-1)
	create_text(-1,tr("MP"))
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
	SoundController.play_effect(SoundController.EFFECTS.staff_heal)
	set_ap(0)
	set_hp(hp+5)

func damage(value):
	if Global.stop: return
	if invincible or dashing or PlayerControll.dead: return
	if $PlayerAnimation.current_animation == "use_magic":
		$PlayerAnimation.stop()
		$Get_Item_Sprite.visible = false
	casting = false
	hit = true
	invincible = true
	SoundController.play_effect(SoundController.EFFECTS.player_hit)
	if is_shield_up:
		value = 0
		neck_of_protection.queue_free()
		is_shield_up = false
	var text = damage_text.instance()
	text.set_text(str(value))
	add_child(text)
	$PlayerAnimation.stop()
	set_hp(hp-value)
	$PlayerAnimation.play("damage_anim")
	yield($PlayerAnimation, "animation_finished")
	$Invincible_Timer.start(1)
	hit = false
	
func recover_mana():
	set_mp(PlayerControll.max_mp)
	var text = float_text.instance()
	text.set_text("MP " + str(PlayerControll.max_mp))
	add_child(text)

func _on_AP_Timer_timeout():
	set_ap(ap+1)

func change_action_area_direction():
	if dir == "right":
		action_area.get_node("action").rotation_degrees = 0
		action_area.get_node("action").flip_h = false
		action_area.position.x = 12
		action_area.position.y = 2
		#Shield
		shield_area.position.x = 7
		shield_area.position.y = 4
		shield_area_sprite.frame = 27
		shield_area.z_index = 1
	elif dir == "left":
		action_area.get_node("action").rotation_degrees = 0
		action_area.get_node("action").flip_h = true
		action_area.position.x = -12
		action_area.position.y = 2
		#Shield
		shield_area.position.x = -7
		shield_area.position.y = 4
		shield_area_sprite.frame = 25
		shield_area.z_index = 1
	elif dir == "up":
		action_area.get_node("action").flip_h = true
		action_area.get_node("action").rotation_degrees = 90
		action_area.position.x = 3
		action_area.position.y = -12
		#Shield
		shield_area.position.x = -3
		shield_area.position.y = -3
		shield_area_sprite.frame = 26
		shield_area.z_index = -1
	elif dir == "down":
		action_area.get_node("action").flip_h = true
		action_area.get_node("action").rotation_degrees = -90
		action_area.position.x = -3
		action_area.position.y = 14
		#Shield
		shield_area.position.x = -3
		shield_area.position.y = 6
		shield_area_sprite.frame = 24
		shield_area.z_index = 1

func execute_action():
	if Input.is_action_just_pressed("action_1"):
		if PlayerControll.equiped_item[0] != -1 and not dashing:
			action(0)
	elif Input.is_action_just_pressed("action_2") and not dashing:
		if PlayerControll.equiped_item[1] != -1:
			action(1)

func movement(): 
	if not dashing:
		speed = PlayerControll.base_speed
		velocity = Vector2.ZERO
		if !action_state:
			if Input.is_action_pressed("move_right"):
				$PlayerAnimation.play("walk_right")
				velocity.x += 1
				dir = "right"
				action_area.knockback_vector = velocity
				shield_area.knockback_vector = velocity * 2
			elif Input.is_action_pressed('move_left'):
				velocity.x -= 1
				$PlayerAnimation.play("walk_left")
				dir = "left"
				action_area.knockback_vector = velocity
				shield_area.knockback_vector = velocity * 2
			elif Input.is_action_pressed('move_down'):
				velocity.y += 1
				$PlayerAnimation.play("walk_down")
				dir = "down"
				action_area.knockback_vector = velocity
				shield_area.knockback_vector = velocity * 2
			elif Input.is_action_pressed('move_up'):
				velocity.y -= 1
				$PlayerAnimation.play("walk_up")
				dir = "up"
				action_area.knockback_vector = velocity 
				shield_area.knockback_vector = velocity * 2
			else:
				$PlayerAnimation.stop()
		if Input.is_action_just_pressed("action_dash") and not dashing and ap >= 2 and not casting and PlayerControll.dash_unlocked and not shield_area.visible:
			dash()
		velocity = velocity.normalized() * speed

func dash():
	if action_area.visible: return
	SoundController.play_effect_with_random_pitch(SoundController.EFFECTS.dash)
	dashing = true
	set_collision_layer_bit(7, true)
	set_collision_mask_bit(7, true)
	set_collision_layer_bit(0, false)
	set_collision_mask_bit(0, false)
	var dash_object = preload("res://Sprites/Animations/Dash/Dash.tscn").instance()
	dash_object.global_position = global_position
	get_tree().get_current_scene().add_child(dash_object)
	set_ap(ap-2)
	match dir:
		"up":
			velocity.y -= 1
			$PlayerAnimation.play("walk_up")
			dash_object.rotation_degrees = 0
		"down":
			velocity.y += 1
			$PlayerAnimation.play("walk_down")
			dash_object.rotation_degrees = 180
		"left":
			velocity.x -= 1
			$PlayerAnimation.play("walk_left")
			dash_object.rotation_degrees = -90
		"right":
			velocity.x += 1
			$PlayerAnimation.play("walk_right")
			dash_object.rotation_degrees = 90
	speed = PlayerControll.base_speed * 2.2
	$Dash_Timer.start()


func _on_Dash_Timer_timeout():
	speed = PlayerControll.base_speed
	dashing = false
	set_collision_layer_bit(0, true)
	set_collision_mask_bit(0, true)
	set_collision_layer_bit(7, false)
	set_collision_mask_bit(7, false)

func _on_Invincible_Timer_timeout():
	invincible = false
	$Sprite.modulate = Color(1,1,1,1)


func play_get_item_animation():
	get_item_anim = true
	Global.stop = true
	$PlayerAnimation.play("get_item")
	yield($PlayerAnimation, "animation_finished")
	Global.stop = false
	get_item_anim = false

func show_item():
	$Get_Item_Sprite.visible = true
	$Get_Item_Sprite.frame = get_item_frame

func show_get_item():
	SoundController.play_effect(SoundController.EFFECTS.positive_10)
	$Get_Item_Sprite.visible = true
	$Get_Item_Sprite.frame = get_item_frame

func hide_get_item():
	$Get_Item_Sprite.visible = false

func set_item_texture(_frame,_texture_type):
	get_item_frame = _frame
	if _texture_type == "weapons":
		$Get_Item_Sprite.texture = weapons_texuture
	else:
		$Get_Item_Sprite.texture = relics_texuture

func _on_Player_Body_area_entered(_area):
	check_projectile_collision(_area)

func check_projectile_collision(_body):
	if _body.is_in_group(Global.GROUPS.ENEMY_PROJECTILES) and not dashing:
		damage(_body.damage)
		_body.queue_free()
	
func create_text(_value, _string):
	var _text = float_text.instance()
	_text.set_text(_string + str(_value))
	add_child(_text)
