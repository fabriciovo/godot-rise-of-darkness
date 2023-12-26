class_name Quest_Tile extends Panel

onready var Unlocked_Panel = $Unlocked_Panel
onready var Locked_Panel = $Locked_Panel

var title = ""
var description = ""
var reward = ""
var progress = 0
var goal = 1
var locked = false


func _process(_delta):
	Unlocked_Panel.visible = locked
	Locked_Panel.visible = !locked

