extends KinematicBody2D

onready var anim = $Animation

var points_top = null
var points_bottom = null
var speed = 50

func _ready():
	var _current = get_tree().current_scene
	points_top = _current.get_node_or_null("Points/Top")
	points_bottom = _current.get_node_or_null("Points/Bottom")
	anim.play("intro")

func _process(_delta):
	if anim.playback_speed <= 1:
		print(anim.playback_speed)
		anim.playback_speed += 0.01 * _delta
		yield(get_tree().create_timer(1.0), "timeout")

func find_new_position():
	pass

func _on_Timer_timeout():
	pass


func intro_end():
	print(anim.playback_speed)
	anim.playback_speed = 0
	print(anim.playback_speed)
	anim.play("anim")
