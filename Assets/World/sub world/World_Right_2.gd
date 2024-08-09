extends Room_Controll

onready var dark_mage_spawn_timer = $Timer
onready var thunder = $Thunder 
onready var door_world_right_1 = $Door_World_Right_1
onready var door_world_right_2 = $Door_World_Right_2
onready var entities = $Entities 
var start_timer = true

var gate = preload("res://Assets/Enviroment/Entities_Gate.tscn")

func _process(_delta):
	if entities.get_children().size() <= 0: return
	if start_timer:
		start_timer = false
		dark_mage_spawn_timer.start(3)

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
	temp_gate_2.position = door_world_right_2.position
	add_child(temp_gate_2)
	dark_mage_spawn_timer.stop()
	Global.stop = true
	thunder.start_left_florest_dark_mage()
