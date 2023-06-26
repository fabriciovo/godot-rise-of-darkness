extends ColorRect


func _ready():
	if Global.player_last_scene.find("Dungeon_") > 0:
		fade_out()

func fade_out():
	$Transition_Animator.play("fade_out_anim")
	yield ($Transition_Animator, "animation_finished")
	
func fade_in():
	$Transition_Animator.play("fade_in_anim")
	yield ($Transition_Animator, "animation_finished")
	var scene_instance =  get_tree().change_scene("res://Assets/Battle/Battle.tscn")
	if scene_instance != OK:
		push_error("Scene not load")
