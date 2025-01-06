extends StaticBody2D

export(String, "Fire_Mage","Dark_Mage", "Necromancer", "Dark_Lord" ) var type

func _ready():
	match type:
		"Fire_Mage":
			pass
		"Dark_Mage":
			pass
		"Necromancer":
			pass
		"Dark_Lord":
			pass

func _input(_event):
	if _event.is_action_pressed("action_3"):
		run_dialog()


func run_dialog():
	pass
