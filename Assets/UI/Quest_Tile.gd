class_name Quest_Tile extends NinePatchRect

onready var Unlocked_Panel = $Unlocked_Panel
onready var Locked_Panel = $Locked_Panel

var title = ""
var description = ""
var reward = ""
var progress = 0
var goal = 1
var unlocked = false
var quest_key = "BAT"

func _ready():
	goal = Global.QUESTS[quest_key]["Goal"]

func _process(_delta):
	Unlocked_Panel.visible = unlocked
	Locked_Panel.visible = !unlocked
	if Global.QUESTS[quest_key]["Progress"] == goal:
		unlocked = true

