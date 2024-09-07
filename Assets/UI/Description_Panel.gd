extends Panel

onready var title = $Description_Title
onready var label = $Description_Label

func _on_upgrade_hp_focus_entered():
	title.text = "MAX_HP_INFO_TITLE"
	label.text = tr("HP_DESCRIPTION")

func _on_upgrade_Magic_focus_entered():
	title.text = "MAX_MP_INFO_TITLE"
	label.text = tr("MP_DESCRIPTION")

func _on_upgrade_action_points_focus_entered():
	title.text = "MAX_AP_INFO_TITLE"
	label.text = tr("AP_DESCRIPTION")

func _on_upgrade_atk_focus_entered():
	title.text = "MAX_ATK_INFO_TITLE"
	label.text = tr("ATK_DESCRIPTION")
