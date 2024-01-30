extends Room_Controll

var tutorial_cutscene = preload("res://Assets/Cutscenes/Tutorial_Cutscene.tscn")

func _process(_delta):
	if Global.trigger_tutorial_animation:
		Global.trigger_tutorial_animation = false
		Global.stop = true
		Global.cutscene = true
		get_node("/root/Ui").add_child(tutorial_cutscene.instance())
