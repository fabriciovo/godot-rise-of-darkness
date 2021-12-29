extends KinematicBody2D

export(String, FILE, "*tscn, *scn") var targetScene


func _ready():
	add_to_group("Door")
	Global.doorName = name





func nextLevel():
	var ERR = get_tree().change_scene(targetScene)
	
	if ERR != OK:
		print("something failed in the door scene")
		
	


func _on_Player_touchDoor():
	nextLevel()
