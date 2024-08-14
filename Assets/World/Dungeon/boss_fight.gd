extends Node2D

onready var text_box = $Text_Box_Layer/Text_Box
var phase = 0
func _ready():
	Global.stop = true
	Global.cutscene = true
#	$AnimationPlayer.play("start_boss")


func start():
	Global.stop = false
	Global.cutscene = false


func intro_dialog():
	text_box.dialog_name = ""
	text_box.start_dialog()

func _on_Text_Box_on_end_dialog():
	match phase:
		0:
			pass
		1:
			pass
		2:
			pass
		3:
			pass
