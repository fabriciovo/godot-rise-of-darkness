extends GridContainer

onready var playerAim = get_tree().current_scene.get_node("PlayerAim")

const heal_button = preload("res://Assets/Buttons/HealActionButton.tscn")
const sword_button = preload("res://Assets/Buttons/SwordActionButton.tscn")
const bow_button = preload("res://Assets/Buttons/BowActionButton.tscn")
const bomb_button = preload("res://Assets/Buttons/SwordActionButton.tscn")
const shoot_button = preload("res://Assets/Buttons/ShootActionButton.tscn")
var shoot_instance = shoot_button.instance()
func _ready():
	for i in PlayerControll.items.size():
		match PlayerControll.items[i]:
			0:
				var instance = sword_button.instance()
				self.add_child(instance)
			1:
				var instance = bow_button.instance()
				self.add_child(shoot_instance)
				self.add_child(instance)
			2:
				var instance = bomb_button.instance()
				self.add_child(instance)
			4:
				var instance = heal_button.instance()
				self.add_child(instance)
	

func _process(delta):
	if playerAim != null:
		if playerAim.active == true:
			for child in get_children():
				if child.name != "ShootActionButton":
					child.visible = false
				else:
					child.visible = true
		else:
			for child in get_children():
				if child.name != "ShootActionButton":
					child.visible = true
				else:
					child.visible = false
	else:
		playerAim = get_tree().current_scene.get_node("PlayerAim")
