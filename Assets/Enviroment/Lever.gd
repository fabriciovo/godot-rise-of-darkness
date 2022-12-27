class_name Lever
extends Area2D

export(int) var item
var ID = ""
var disable = false

onready var interactButton = get_node("InteractionButton")

func _ready():
	interactButton.visible = false;
	ID = name

func _process(delta):
	if get_overlapping_areas().size() > 0:
		interactButton.visible = true
	else:
		interactButton.visible = false
	if Global.boss_gate:
		$Sprite.frame = 19
	else:
		$Sprite.frame = 18
func _input(event):
	if event.is_action_pressed("action_3") and not disable and not Global.boss_gate:
		if get_overlapping_areas().size() > 0:
			Global.boss_gate = true
