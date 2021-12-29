extends KinematicBody2D

onready var action_sprite = $action

var max_hp = 25
var max_ap = 3
var max_mp = 10
var hp = max_hp setget set_hp
var ap = max_ap setget set_ap
var mp = max_mp setget set_mp
var items = [] setget set_item
var equiped_item = [-1,-1] 


var dir = "right"
var speed = 30  # speed in pixels/sec
var velocity = Vector2.ZERO

func set_hp(value):
	hp = clamp(value, 0 , max_hp)
	emit_signal("hp_changed", hp)

func set_ap(value):
	ap = clamp(value, 0 , max_ap)
	emit_signal("ap_changed", ap)
	if ap == 0:
		emit_signal("end_turn")

func set_mp(value):
	mp = min(value, max_mp)
	emit_signal("mp_changed", mp)

func set_item(value):
	items.push_front(value)
	
func set_equiped_item(value, slot):
	equiped_item[slot] = value
	emit_signal("equiped_item", value, slot)

signal encounter(enemy)
signal updateUI(player)
signal touchDoor

signal hp_changed(value)
signal ap_changed(value)
signal mp_changed(value)
signal equiped_item(value)

func _ready():
	action_sprite.visible = false

func _process(delta):
	if dir == "right":
		action_sprite.position.x = 10
		action_sprite.position.y = 2
	elif dir == "left":
		action_sprite.position.x = -8
		action_sprite.position.y = 2
	elif dir == "up":
		action_sprite.position.y = -8
		action_sprite.position.x = 1
	elif dir == "down":
		action_sprite.position.y = 10
		action_sprite.position.x = 1


func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed('ui_right'):
		$PlayerAnimation.play("walk_right")
		velocity.x += 1
		dir = "right"
	elif Input.is_action_pressed('ui_left'):
		velocity.x -= 1
		$PlayerAnimation.play("walk_left")
		dir = "left"
	elif Input.is_action_pressed('ui_down'):
		velocity.y += 1
		$PlayerAnimation.play("walk_down")
		dir = "down"
	elif Input.is_action_pressed('ui_up'):
		velocity.y -= 1
		$PlayerAnimation.play("walk_up")
		dir = "up"
	else:
		$PlayerAnimation.stop()
	# Make sure diagonal movement isn't faster
	velocity = velocity.normalized() * speed
	
	if Input.is_action_pressed("action_1"):
		action(0)
	elif Input.is_action_pressed("action_2"):
		action(1)
		
	
	
func action(value):
	action_sprite.visible = true
	action_sprite.frame = 1
	$PlayerAnimation.play("action")
	yield($PlayerAnimation, "animation_finished")
	action_sprite.visible = false
	
func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)

func _on_Area2D_body_entered(body):
	if body.is_in_group("Enemy"):
		emit_signal("encounter", body)
	if body.is_in_group("Door"):
		emit_signal("touchDoor")
		

func check_slot():
	if equiped_item[0] <= 0:
		return 0
	elif equiped_item[1] <= 0:
		return 1


func _on_Chest_get_item(item):
	set_item(item)
	set_equiped_item(item,check_slot())
