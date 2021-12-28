extends KinematicBody2D

onready var animation = $AnimationPlayer.play("walk_sides")

var speed = 30  # speed in pixels/sec
var velocity = Vector2.ZERO

func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed('ui_right'):
		$AnimationPlayer.play("walk_right")
		velocity.x += 1
	elif Input.is_action_pressed('ui_left'):
		velocity.x -= 1
		$AnimationPlayer.play("walk_left")
	elif Input.is_action_pressed('ui_down'):
		velocity.y += 1
		$AnimationPlayer.play("walk_down")
	elif Input.is_action_pressed('ui_up'):
		velocity.y -= 1
		$AnimationPlayer.play("walk_up")
	# Make sure diagonal movement isn't faster
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)

func _on_Area2D_body_entered(body):
	print("dsfiojfopisadjo")
	print(body)
	get_tree().change_scene("res://Assets/Battle/Battle.tscn")

