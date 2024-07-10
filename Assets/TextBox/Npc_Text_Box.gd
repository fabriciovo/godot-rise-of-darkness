extends StaticBody2D

export(String, FILE, "*.tscn,*.scn") var target_scene
export(String) var door_name
var can_pass = false
func _ready():
	if PlayerControll.inventory.size() > 0:
		queue_free()
	add_to_group(Global.GROUPS.DOOR_WITH_INTERACTION)

func _process(_delta):
	if PlayerControll.inventory.size() == 0:
		can_pass = false
	else:
		can_pass = true

func trigger_dialog_box():
	Global.stop = true
	$CanvasLayer/Control/Text_Box.dialog_name = "you_need_a_weapon.json"
	$CanvasLayer/Control/Text_Box.start_dialog()


func _on_Text_Box_on_end_dialog():
	Global.stop = false
