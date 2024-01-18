extends CanvasLayer

onready var transition = $Fill
onready var animation = $Fill/Transition_Animator

export (int, "Pixels", "Spot Player", "Spot Center","Slah V", "Slash H") var transition_type
export (int, "Fade In", "Fade Out", "None") var execute
var duration: float  = 0.2

func _ready():
	if Global.execute_transition_animation == false: 
		Global.stop = false
		queue_free()
	elif execute == 0:
		fade_in()
	elif execute == 1:
		fade_out()

func fade_out():
	Global.stop = true
	transition.material.set_shader_param("type", transition_type)
	animation.playback_speed = duration
	animation.play("fade_out_anim")
	yield (animation, "animation_finished")
	Global.stop = false
	Global.execute_transition_animation = false
	queue_free()
	
func fade_in():
	Global.execute_transition_animation = false
	Global.stop = true
	transition.material.set_shader_param("type", transition_type)
	animation.playback_speed = duration
	animation.play("fade_in_anim")
	yield (animation, "animation_finished")
	Global.stop = false
	queue_free()
