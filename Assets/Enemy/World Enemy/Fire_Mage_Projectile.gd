class_name Fire_Mage_Projectile extends Simple_Projectile

var fire_enemy = preload("res://Assets/Enemy/World Enemy/World_Fire_Spirit.tscn")
var can_instance = preload("res://Assets/Enemy/Can_Instance_Dinamic_World_Enemy.tscn")

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
	var _can_instance = can_instance.instance()
	_can_instance.inst = fire_enemy.instance()
	_can_instance.position = position
	get_tree().current_scene.add_child(_can_instance)
	queue_free()
