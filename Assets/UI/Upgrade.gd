extends Button

onready var upgrades_container = get_parent().get_node("Upgrades")

func _process(delta):
#	if PlayerControll.points > 0:
#		visible = true
#		disabled = false
#	else:
#		visible = false
#		disabled = true
	pass


func _on_Upgrade_pressed():
	upgrades_container.visible = true

