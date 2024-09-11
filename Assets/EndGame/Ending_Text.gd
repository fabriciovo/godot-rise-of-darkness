extends Control

onready var container = $Text_Container
var speed = 8

func _ready():
	Global.in_game = false
	Ui.game_ui.visible = false

func _input(_event):
	if  _event.is_action_pressed("action_1"):
		speed = 100
	if _event.is_action_pressed("action_2"):
		speed = 8
	if _event.is_action_pressed("action_3"):
		speed = 0
