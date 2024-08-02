extends Room_Controll

onready var dark_mage_spawn_timer = $Timer
onready var thunder = $Thunder 


func _ready():
	._ready()
	dark_mage_spawn_timer.start(3)


func _on_Timer_timeout():
	dark_mage_spawn_timer.stop()
	Global.stop = true
	thunder.florest_dark_mage()
