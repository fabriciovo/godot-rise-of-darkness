extends Panel

onready var title = $Description_Title
onready var label = $Description_Label

func _on_upgrade_hp_focus_entered():
	title.text = "MAX_HP_INFO_TITLE"
	label.text = "MAX_HP_DESCRIPTION"

func _on_upgrade_Magic_focus_entered():
	title.text = "MAX_MP_INFO_TITLE"
	label.text = "MAX_MP_DESCRIPTION"

func _on_upgrade_action_points_focus_entered():
	title.text = "AP_INFO_TITLE"
	label.text = "AP_DESCRIPTION"

func _on_upgrade_atk_focus_entered():
	title.text = "ATK_INFO_TITLE"
	label.text = "ATK_DESCRIPTION"
