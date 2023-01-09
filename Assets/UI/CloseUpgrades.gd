extends Button

onready var max_stats = get_parent().get_parent().get_node("Max Stats")

func _on_Close_Upgrades_pressed():
	get_parent().visible = false
	max_stats.visible = false
