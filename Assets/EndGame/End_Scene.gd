class_name End_Scene extends Node2D

export (String, "End_2", "End_3", "End_4") var go_to_end

onready var thunder = $Thunder
onready var monster = $Monsters

func _on_Timer_timeout():
	thunder.play_flash()
	yield(get_tree().create_timer(1.1), "timeout")
	monster.queue_free()
	yield(get_tree().create_timer(1.1), "timeout")
	var scene_instance = get_tree().change_scene("res://Assets/EndGame/End_2.tscn")
