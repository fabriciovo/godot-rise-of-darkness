extends Room_Controll

onready var dark_mage_spawn_timer = $Timer
onready var thunder = $Thunder 
onready var door = $Door
onready var entities = $Entities 
onready var fire_spawn_points = $Points
onready var fake_chest = $Fake_Chest
var gate = preload("res://Assets/Enviroment/Entities_Gate.tscn")
var fire_spirit = preload("res://Assets/Enemy/World Enemy/World_Fire_Spirit.tscn")
var smoke = preload("res://Assets/Animations/smoke.tscn")

func _ready():
	if not Global.dark_mages.fire_mage:
		dark_mage_spawn_timer.start(3)
		thunder.mage_name = "left_dark_mage"

func _on_Timer_timeout():
	var fire_spawn_points_childrens = fire_spawn_points.get_children() 
	if Ui.pause_options.visible:
		Ui.pause_options.visible = false
	Global.cutscene = true
	SoundController.stop_music()
	var temp_gate = gate.instance()
	temp_gate.position = door.position
	temp_gate.rotation_degrees = 90
	for fire in fire_spawn_points_childrens:
		var _fire_inst = fire_spirit.instance()
		var _smoke_inst = smoke.instance()
		_smoke_inst.position = fire.position
		add_child(_smoke_inst)
		_fire_inst.position = fire.position
		entities.add_child(_fire_inst)
	add_child(temp_gate)
	Global.stop = true
	dark_mage_spawn_timer.stop()
	thunder.start_florest_dark_mage()
	fake_chest.queue_free()

	

