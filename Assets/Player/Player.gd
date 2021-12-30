extends KinematicBody2D


onready var action_area = $ActionArea
onready var action_sprite =  $ActionArea/action
onready var action_collision =  $ActionArea/AreaCollision

signal encounter(enemy)
signal touchDoor(door_name)

var dir = "right"
var speed = 30  # speed in pixels/sec
var velocity = Vector2.ZERO
var action_state = false

func _ready():
	action_collision.disabled = true
	action_area.visible = false

func get_input():
	velocity = Vector2.ZERO
	
	if !action_state:
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
		if PlayerControll.equiped_item[0] != -1:
			action(0)
	elif Input.is_action_pressed("action_2"):
		if PlayerControll.equiped_item[1] != -1:
			action(0)
			
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
	action_sprite.frame = 1
	action_collision.disabled = false
	$PlayerAnimation.play("action")
	yield($PlayerAnimation, "animation_finished")
	action_area.visible = false
	action_state = false
	action_collision.disabled = true
	
func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)

func check_slot():
	if PlayerControll.equiped_item[0] <= 0:
		return 0
	elif PlayerControll.equiped_item[1] <= 0:
		return 1

func _on_Chest_get_item():
	PlayerControll.set_equiped_item(1,check_slot())
	PlayerControll.set_item("sword")

func _on_Area2D_body_entered(body):
	if body.is_in_group("Enemy"):
		#emit_signal("encounter", body)
		get_tree().change_scene("res://Assets/Battle/Battle.tscn")
	if body.is_in_group("Door"):
		Global.doorName = body.name
		get_tree().change_scene(body.target_scene)

func _on_ActionArea_body_entered(body):
	if body.is_in_group("Stone"):
		body.queue_free()
