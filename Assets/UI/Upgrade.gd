extends Button

onready var upgrades_container = get_parent().get_node("Upgrades")
onready var max_stats = get_parent().get_node("Max Stats")

func _process(delta):
	if PlayerControll.points > 0:
		visible = true
		disabled = false
	else:
		visible = false
		disabled = true


func _on_Upgrade_pressed():
	upgrades_container.visible = true
	max_stats.visible = true
