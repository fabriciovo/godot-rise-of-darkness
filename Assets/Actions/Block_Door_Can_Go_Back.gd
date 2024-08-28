extends StaticBody2D
var can_pass = false

func _ready():
	add_to_group(Global.GROUPS.DOOR_WITH_INTERACTION)

func trigger_dialog_box():
	Global.stop = true
	$CanvasLayer/Control/Text_Box.dialog_name = "you_cant_go_back.json"
	$CanvasLayer/Control/Text_Box.start_dialog()

func _on_Text_Box_on_end_dialog():
	Global.stop = false
