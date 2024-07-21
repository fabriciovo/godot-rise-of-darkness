extends CanvasLayer

onready var text_box = $Control/Text_Box

func _ready():
	text_box.dialog_name = "level_up_dialog.json"
	text_box.start_dialog()

func _on_Text_Box_on_end_dialog():
	Global.stop = false
	queue_free()
