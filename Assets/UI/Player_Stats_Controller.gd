extends Panel

onready var points = get_node("Points")
onready var buttons = $Upgrade_Panel.get_children()

func _process(_delta):
	points.text = tr("POINTS") + ":" + str(PlayerControll.points)
	if PlayerControll.points > 0:
		for button in buttons:
			button.disabled = false
	else:
		for button in buttons:
			button.disabled = true

func _on_upgrade_hp_pressed():
	if PlayerControll.points >= 1:
		PlayerControll.increase_max_hp()

func _on_upgrade_atk_pressed():
	if PlayerControll.points >= 1:
		PlayerControll.increase_atk()

func _on_upgrade_Magic_pressed():
	if PlayerControll.points >= 1:
		PlayerControll.increase_max_mp()

func _on_upgrade_action_points_pressed():
	if PlayerControll.points >= 1:
		PlayerControll.increase_max_ap()
