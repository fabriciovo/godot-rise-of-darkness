extends Room_Controll

onready var dark_mage_spawn_timer = $Timer
onready var thunder = $Thunder 
onready var door = $Door
onready var entities = $Entities 

var gate = preload("res://Assets/Enviroment/Entities_Gate.tscn")

func _ready():
	if not Global.dark_mages.left_florest_dark_mage:
		dark_mage_spawn_timer.start(3)

func _on_Timer_timeout():
	if Ui.pause_options.visible:
		Ui.pause_options.visible = false
	Global.cutscene = true
	SoundController.stop_music()
	var temp_gate = gate.instance()
	temp_gate.position = door.position
	temp_gate.rotation_degrees = 90
	add_child(temp_gate)
	dark_mage_spawn_timer.stop()
	Global.stop = true
	thunder.florest_dark_mage()
