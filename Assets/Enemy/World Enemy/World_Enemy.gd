class_name World_Enemy
extends KinematicBody2D

export (String) var ID

onready var frame = $Sprite.frame
onready var timer = $Timer

var smoke = preload("res://Assets/Animations/smoke.tscn").instance()
var knockback = Vector2.ZERO
var hp = 1
var hit = false
var speed = 10
var const_speed = 0
func _ready():
	add_to_group(Global.GROUPS.ENEMY)


func _on_Timer_timeout():
	pass


func Destroy():
	Global.dead_enemies.push_front(ID)
	$Sprite.visible = false
	add_child(smoke)
	yield(smoke.get_node("AnimationPlayer"),"animation_finished")
	queue_free()

func Knockback():
		hit = true
		$Enemy_Animation.play("damage_anim")
		yield($Enemy_Animation, "animation_finished")
		hp+=1
		if hp >= 4:
			Destroy()
		else:
			timer.start(1)


		
func _on_Area_area_entered(area):
	if area.is_in_group(Global.GROUPS.SWORD):
		knockback = area.knockback_vector * 120
		Knockback()


func _on_Area_body_entered(body):
	if body.is_in_group(Global.GROUPS.ARROW):
		knockback = body.knockback_vector * 120
		body.queue_free()
		Knockback()
	if body.is_in_group(Global.GROUPS.BOMB):
		print("Okasfpdokpoafskposka")
		knockback = -global_position * 120
		Knockback()
