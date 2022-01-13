extends KinematicBody2D

export (String) var ID
onready var frame = $Sprite.frame
const battle_unit_damage = 3
const battle_unit_hp = 10

var smoke = preload("res://Assets/Animations/smoke.tscn").instance()

onready var obj = get_parent().get_parent().get_node("Player")
onready var timer = $Timer
var speed = 10
var knockback = Vector2.ZERO
var direction = Vector2(-20, 20)
var velocity=Vector2(20,20)
var hp = 1
var hit = false



func _ready():
	$Bat_Animation.play("Bat_anim")
	add_to_group(Global.GROUPS.ENEMY)
	randomize()
	direction.x = rand_range(-20, 20)
	direction.y = rand_range(-20, 20)


func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = move_and_slide(knockback) 

	if obj and not hit:
		var dir = (obj.global_position - global_position).normalized()
		move_and_collide(dir * speed * delta)
		



func _on_Body_area_entered(area):
	if area.name == "ActionArea":
		knockback = area.knockback_vector * 90
		hit = true
		$Bat_Animation.play("damage_anim")
		timer.start(1)
		



func _on_Timer_timeout():
	timer.stop()
	hp+=1
	if hp > 3:
		Destroy()
	else:
		speed = speed * hp
		hit = false
		$Bat_Animation.play("Bat_anim")

func Destroy():
	Global.dead_enemies.push_front(ID)
	$Sprite.visible = false
	add_child(smoke)
	yield(smoke.get_node("AnimationPlayer"),"animation_finished")
	queue_free()
