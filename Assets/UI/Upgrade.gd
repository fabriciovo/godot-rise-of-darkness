extends Panel


func _process(_delta):
	if PlayerControll.points > 0 and get_tree().get_current_scene().name != "Title_Scene" and get_tree().get_current_scene().name != "Game_Over":
		visible = true
	else:
		visible = false

