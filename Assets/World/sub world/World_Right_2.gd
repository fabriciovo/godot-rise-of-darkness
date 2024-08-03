extends Room_Controll

onready var dark_mage_spawn_timer = $Timer
onready var thunder = $Thunder 
onready var door_world_right_1 = $Door_World_Right_1
onready var door_world_right_2 = $Door_World_Right_2
onready var entities = $Entities

var gate = preload("res://Assets/Enviroment/Entities_Gate.tscn")

func _ready():
	._ready()
	var entities_size = entities.get_children().size()
	if entities_size > 0:
		dark_mage_spawn_timer.start(3)

func _on_Timer_timeout():
	var temp_gate_1 = gate.instance()
	var temp_gate_2 = gate.instance()
	temp_gate_1.position = door_world_right_1.position
	temp_gate_1.rotation_degrees = 90
	add_child(temp_gate_1)
	temp_gate_2.position = door_world_right_2.position
	add_child(temp_gate_2)
	dark_mage_spawn_timer.stop()
	Global.stop = true
	thunder.florest_dark_mage()
