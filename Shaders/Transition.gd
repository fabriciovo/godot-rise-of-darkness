extends ColorRect


func _ready():
	$Transition_Animator.play("fade_out_anim")


func _on_Player_change_scene(target_scene):
	$Transition_Animator.play("fade_in_anim")
	yield ($Transition_Animator, "animation_finished")
	get_tree().change_scene(target_scene)
