class_name Fire_Mage_Projectile extends Simple_Projectile

var fire_enemy = preload("res://Assets/Enemy/World Enemy/World_Fire_Spirit.tscn")
var smoke = preload("res://Assets/Animations/smoke.tscn")
func _ready():
	speed = 20
	$Timer.start(2)

func _physics_process(delta):
	if Global.stop: return
	var velocity = direction * speed
	position += velocity * delta
	if is_out_of_bounds():
		queue_free()


func is_out_of_bounds():
	var screen_size = get_viewport().size
	return position.x < 0 or position.y < 0 or position.x > screen_size.x or position.y > screen_size.y


func _on_Simple_Projectile_area_entered(area):
	if area.is_in_group(Global.GROUPS.SHIELD):
		queue_free()

func _on_Timer_timeout():
	var _overlapping_bodies = get_overlapping_bodies()
	if _overlapping_bodies.size() > 0:
		queue_free()
	else:
		var _fire_enemy_inst = fire_enemy.instance()
		var _smoke_inst = smoke.instance()
		_fire_enemy_inst.position = position
		_smoke_inst.position = position
		get_tree().current_scene.add_child(_smoke_inst)
		get_tree().current_scene.add_child(_fire_enemy_inst)
		queue_free()
