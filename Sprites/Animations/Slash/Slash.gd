extends Sprite

var slash_list = ["slash_0_anim","slash_1_anim","slash_2_anim","slash_3_anim"]

func _on_AnimationPlayer_animation_finished(_anim_name):
	$AnimationPlayer.stop()
	visible = false
