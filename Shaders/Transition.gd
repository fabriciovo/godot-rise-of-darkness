extends CanvasLayer

onready var transition = $Fill
onready var animation = $Fill/Transition_Animator

export (int, "Pixels", "Spot Player", "Spot Center","Slah V", "Slash H") var transition_type
export (int, "Fade In", "Fade Out", "None") var execute
var duration: float  = 0.5



func _ready():
	if execute == 0:
		transition.material.set_shader_param("type", transition_type)
		fade_in()
	if execute == 1:
		transition.material.set_shader_param("type", transition_type)
		fade_out()


func fade_out():
	animation.play("fade_out_anim")
	yield (animation, "animation_finished")
	
func fade_in():
	animation.play("fade_in_anim")
	yield (animation, "animation_finished")
	var scene_instance =  get_tree().change_scene("res://Assets/Battle/Battle.tscn")
	if scene_instance != OK:
		push_error("Scene not load")
