extends Panel

onready var points = get_node("Points")

func _process(_delta):
	points.text = "Points: " + str(PlayerControll.points)
	if PlayerControll.points > 0:
		$"upgrade hp".disabled = false
		$"upgrade atk".disabled = false
		$"upgrade Magic".disabled = false
		$"upgrade action points".disabled = false
	else:
		$"upgrade hp".disabled = true
		$"upgrade atk".disabled = true
		$"upgrade Magic".disabled = true
		$"upgrade action points".disabled = true

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
