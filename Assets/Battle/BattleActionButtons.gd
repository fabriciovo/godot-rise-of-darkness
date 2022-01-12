extends GridContainer


const heal_button = preload("res://Assets/Buttons/HealActionButton.tscn")
const sword_button = preload("res://Assets/Buttons/SwordActionButton.tscn")

func _ready():
	for i in PlayerControll.items.size():
		match PlayerControll.items[i]:
			0:
				var instance = sword_button.instance()
				self.add_child(instance)
			1:
				var instance = heal_button.instance()
				self.add_child(instance)
			2:
				var instance = sword_button.instance()
				self.add_child(instance)
			3:
				var instance = sword_button.instance()
				self.add_child(instance)


