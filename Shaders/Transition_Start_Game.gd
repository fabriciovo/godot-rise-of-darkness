extends CanvasLayer

onready var transition = $Fill
onready var animation = $Fill/Transition_Animator
#var player_anim = get_tree().current_scene.get_node("Player").get_node("PlayerAnimation")

signal end_fade_out
signal end_fade_in

export (int, "Pixels", "Spot Player", "Spot Center","Slah V", "Slash H", "Smooth") var transition_type
export (int, "Fade In", "Fade Out", "None") var execute
export (int, "Execute on Start", "None") var execute_on_start = 0
var duration: float  = 0.2

func _ready():
	if execute_on_start == 0:
	#	if Global.execute_transition_animation:
	#		player_anim.play("intro_anim")
	#	if Global.execute_transition_animation == false: 
	#		Global.stop = false
	#		queue_free()
		if execute == 0:
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
	emit_signal("end_fade_out")
	
func fade_in():
	Global.execute_transition_animation = false
	Global.stop = true
	transition.material.set_shader_param("type", transition_type)
	animation.playback_speed = duration
	animation.play("fade_in_anim")
	yield (animation, "animation_finished")
	Global.stop = false
	emit_signal("end_fade_in")
