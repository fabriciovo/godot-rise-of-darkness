extends World_Enemy

onready var anim = $AnimationPlayer
onready var sprite = $Sprite

var direction = Vector2.ZERO
var projectile = preload("res://Assets/Enemy/World Enemy/enemy_projectile.tscn")
var attacking = false
func _ready():
	battle_unit_max_hp = 4
	battle_unit_damage = 0
	battle_unit_hp = battle_unit_max_hp 
	add_to_group(Global.GROUPS.ENEMY)
	const_speed = 20
	direction.x = const_speed
	$Attack_Timer.start(4)

func _physics_process(_delta):
	if attacking: return
	var collision = move_and_collide(direction * _delta)
	if collision:
		direction = direction.bounce(collision.normal)
	direction.y = 0
	if direction.x >= 1:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
	if direction.x != 0:
		anim.play("sides")

func _on_Timer_timeout():
	hit = false
	timer.stop()


func _on_Attack_Timer_timeout():
	$Attack_Timer.start(4)
	var attack = projectile.instance()
	attack.global_position = global_position
	direction.x = 0
	attacking = true
	anim.play("attack_anim")
	get_tree().get_current_scene().add_child(attack)
	yield(anim, "animation_finished")
	attacking = false
	direction.x = const_speed

func _on_Area_body_entered(body):
	if body.is_in_group(Global.GROUPS.ARROW):
		damage(1, PlayerControll.atk+1)
		body.queue_free()

