extends ColorRect


func _ready():
	fade_out()

func fade_out():
	$Transition_Animator.play("fade_out_anim")
	yield ($Transition_Animator, "animation_finished")
	
func fade_in():
	$Transition_Animator.play("fade_in_anim")
	yield ($Transition_Animator, "animation_finished")
	get_tree().change_scene("res://Assets/Battle/Battle.tscn")
