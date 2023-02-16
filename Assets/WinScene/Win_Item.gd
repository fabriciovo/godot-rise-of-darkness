extends Area2D

func _on_Win_Item_body_entered(body):
	if body.is_in_group(Global.GROUPS.PLAYER):
		get_tree().change_scene("res://Assets/WinScene/Win.tscn")

