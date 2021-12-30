extends GridContainer

const action_button = preload("res://Assets/Player/ActionButton.tscn")
var buttons = []

func _ready():
	for i in PlayerControll.items.size():
		var instance = action_button.instance()
		self.add_child(instance)


