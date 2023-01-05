class_name World_Enemy
extends KinematicBody2D

var ID = name
onready var frame = $Sprite.frame
onready var timer = $Timer

var smoke = preload("res://Assets/Animations/smoke.tscn").instance()
var knockback = Vector2.ZERO
var hp = 1
var hit = false
var speed = 10
var const_speed = 0
var normal_speed = speed
var damageText = preload("res://Assets/UI/DamageText.tscn")


func _ready():
	add_to_group(Global.GROUPS.ENEMY)
	Enable()


func _process(delta):
	if(!Global.stop):
		set_physics_process(true)
	else:
		set_physics_process(false)


func _on_Timer_timeout():
	hit = false


func Destroy():
	Global.dead_enemies.push_front(ID)
	Disable()
	add_child(smoke)
	yield(smoke.get_node("AnimationPlayer"),"animation_finished")
	queue_free()

func Knockback():
		var text = damageText.instance()
		text.set_text(str(PlayerControll.atk))
		add_child(text)
		hit = true
		$Enemy_Animation.play("damage_anim")
		yield($Enemy_Animation, "animation_finished")
		hp+=1
		if hp >= 4:
			Destroy()
		else:
			timer.start(1)

func _on_Area_area_entered(area):
	if area.is_in_group(Global.GROUPS.SWORD) and not hit:
		knockback = area.knockback_vector * 120
		Knockback()

func _on_Area_body_entered(body):
	if body.is_in_group(Global.GROUPS.ARROW) and not hit:
		knockback = body.knockback_vector * 120
		body.queue_free()
		Knockback()
	if body.is_in_group(Global.GROUPS.BOMB) and not hit:
		knockback = -global_position
		Knockback()


func Disable():
	speed = 0
	set_physics_process(false);
	$Body_Shape.disabled = true
	$Area/Area_Shape.disabled = true
	$Sprite.visible = false

func Enable():
	set_physics_process(true);
	speed = normal_speed
	$Body_Shape.disabled = false
	$Area/Area_Shape.disabled = false
	$Sprite.visible = true
