extends Control


func _ready():
	$Label.bbcode_text = tr("CREDITS_TEXT")

func _input(_event):
	if visible:
		if _event.is_action_pressed("action_2"):
			visible = false
			get_tree().current_scene.get_node("Pause_Button_Container/Start").grab_focus()
