extends Panel

onready var points = get_node("Points")

func _process(delta):
	points.text = "Points: " + str(PlayerControll.points)


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
