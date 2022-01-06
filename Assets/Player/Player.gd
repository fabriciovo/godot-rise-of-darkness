extends KinematicBody2D

onready var action_area = $ActionArea
onready var action_sprite =  $ActionArea/action
onready var action_collision =  $ActionArea/AreaCollision
onready var actionArea = $ActionArea

signal encounter(enemy)
signal change_scene(target_scene, value)

var dir = "right"
var speed = 30
var velocity = Vector2.ZERO
var action_state = false


func _ready():
	action_collision.disabled = true
	action_area.visible = false
	actionArea.knockback_vector = Vector2.LEFT

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
	action_state = true
	action_area.visible = true
	action_sprite.frame = PlayerControll.equiped_item[value]
	action_collision.disabled = false
	
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
	get_input()
	velocity = move_and_slide(velocity)

func _on_Area2D_body_entered(body):
	if body.is_in_group("Enemy"):
		#emit_signal("encounter", body)
		Global.last_enemy = body.ID
		Global.enemy_battle_unit_damage = body.battle_unit_damage
		Global.enemy_battle_unit_hp = body.battle_unit_hp
		Global.enemy_frame = body.frame
		get_tree().change_scene("res://Assets/Battle/Battle.tscn")
	if body.is_in_group("Door"):
		emit_signal("change_scene",body.target_scene, body.door_name)

func _on_ActionArea_body_entered(body):
	if body.is_in_group("Stone"):
		body.Destroy()

func _on_Player_change_scene(target_scene):
	pass # Replace with function body.
