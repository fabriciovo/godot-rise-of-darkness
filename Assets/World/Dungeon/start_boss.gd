extends Node2D

func _ready():
	Global.stop = true
	$AnimationPlayer.play("start_boss")


func start():
	Global.stop = false
