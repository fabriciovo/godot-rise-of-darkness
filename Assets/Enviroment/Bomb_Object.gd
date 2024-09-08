class_name Bomb_Object
extends KinematicBody2D

func _ready():
	add_to_group(Global.GROUPS.BOMB)

func on_explosion():
	$Explosion_area.disabled = false

func _on_AnimationPlayer_animation_finished(_anim_name):
	queue_free()
