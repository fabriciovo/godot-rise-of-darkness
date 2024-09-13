extends Node2D

onready var anim = $Animation_Player

var dragon = preload("res://Assets/Enemy/Boss/World_Dragon_Boss.tscn")

var left_pos = Vector2.ZERO
var right_pos = Vector2.ZERO
var up_pos = Vector2.ZERO
var down_pos = Vector2.ZERO
var landing_pos = Vector2.ZERO
var target_index = 0
var speed = 50

func _ready():
	get_positions_node()

func _process(_delta):
	move_to_point(_delta)

func get_positions_node():
	var _flying_dragon_points = get_tree().current_scene.get_node("Flying_Dragon_Points")
	left_pos = _flying_dragon_points.get_node("Left").position
	right_pos = _flying_dragon_points.get_node("Right").position
	up_pos = _flying_dragon_points.get_node("Up").position
	down_pos = _flying_dragon_points.get_node("Down").position 
	landing_pos = _flying_dragon_points.get_node("Landing").position 
	position = left_pos

func move_to_point(_delta):
		if target_index == 0:
			anim.play("side")
			position = position.move_toward(right_pos, _delta * speed)
			if position == right_pos:
				target_index+=1
		elif target_index == 1:
			position = position.move_toward(left_pos, _delta * speed)
			anim.play("side")
			$Sprite.flip_h = true
			if position == left_pos:
				target_index+=1
				position = down_pos
		elif target_index == 2:
			position = position.move_toward(up_pos, _delta * speed)
			anim.play("up")
			$Sprite.flip_h = false
			if position == up_pos:
				position = up_pos
				target_index+=1
		elif target_index == 3:
			anim.play("down")
			position = position.move_toward(down_pos, _delta * speed)
		elif target_index == 4:
			anim.play("landing")
			position = position.move_toward(landing_pos, _delta * 30 )
			

func _on_Animation_Player_animation_finished(_anim_name):
	if _anim_name == "down":
		target_index+=1
		position = down_pos
		$Sprite.visible = true
		$Sprite.scale.x = 2
		$Sprite.scale.y = 2
	if _anim_name == "landing":
		Global.stop = true
		visible = false
		var _inst = dragon.instance()
		_inst.position = position
		get_tree().current_scene.add_child(_inst)
		visible = false
		yield(get_tree().create_timer(3), "timeout")
		Global.stop = false
		queue_free()
