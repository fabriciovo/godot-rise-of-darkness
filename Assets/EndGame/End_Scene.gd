class_name End_Scene extends Node2D


onready var transition = $Transition
onready var thunder = $Thunder


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_Timer_timeout():
	thunder.play_flash()
	yield(thunder.animation, "finished_animation")
