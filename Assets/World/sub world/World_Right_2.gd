extends Room_Controll

onready var dark_mage_spawn_timer = $Timer
onready var thunder = $Thunder 
onready var door_world_right_1 = $Door_World_Right_1
onready var door_world_right_2 = $Door_World_Right_2
onready var entities = $Entities 

var gate = preload("res://Assets/Enviroment/Door_Dark_Mage.tscn")

func _ready():
	if not Global.dark_mages.dark_mage:
		dark_mage_spawn_timer.start(3)
		thunder.mage_name = "right_dark_mage"

func _on_Timer_timeout():
	if Ui.pause_options.visible:
		Ui.pause_options.visible = false
	Global.cutscene = true
	SoundController.stop_music()
	var temp_gate_1 = gate.instance()
	var temp_gate_2 = gate.instance()
	temp_gate_1.position = door_world_right_1.position
	temp_gate_1.rotation_degrees = 90
	add_child(temp_gate_1)
	temp_gate_1.create_smoke()
	temp_gate_2.position = door_world_right_2.position
	add_child(temp_gate_2)
	temp_gate_2.create_smoke()
	dark_mage_spawn_timer.stop()
	Global.stop = true
	thunder.start_florest_dark_mage()
