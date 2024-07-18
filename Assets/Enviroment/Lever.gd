class_name Lever extends Area2D

var ID = ""
var player_in_area = false

func _ready():
	ID = name

func _process(_delta):
	if Global.boss_gate:
		$Sprite.frame = 19
	else:
		$Sprite.frame = 18

func _input(_event):
	if _event.is_action_pressed("action_3") and player_in_area and not Global.boss_gate:
		if player_in_area:
			Global.boss_gate = true


func _on_Lever_body_entered(_body):
	if _body.is_in_group(Global.GROUPS.PLAYER):
		player_in_area = true


func _on_Lever_body_exited(_body):
	if _body.is_in_group(Global.GROUPS.PLAYER):
		player_in_area = false
