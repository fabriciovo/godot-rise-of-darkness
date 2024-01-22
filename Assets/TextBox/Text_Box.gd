extends MarginContainer
 
export var dialogPath = ""
export(float) var textSpeed = 0.05

onready var label_name = $MarginContainer/HBoxContainer/Name
onready var label_text = $MarginContainer/HBoxContainer/Label
onready var timer = $Timer
 
var dialog
var phraseNum = 0
var finished = false
 
func _ready():
	timer.wait_time = textSpeed
	dialog = getDialog()
	assert(dialog, "Dialog not found")
	nextPhrase()
 
func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		if finished:
			nextPhrase()
		else:
			label_text.visible_characters = len(label_text.text)
 
func getDialog():
	var f = File.new()
	assert(f.file_exists(dialogPath), "File path does not exist")
	
	f.open(dialogPath, File.READ)
	var json = f.get_as_text()
	
	var output = parse_json(json)
	
	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return []
 
func nextPhrase():
	if phraseNum >= len(dialog):
		queue_free()
		return
	
	finished = false
	
	label_name.bbcode_text = dialog[phraseNum]["Name"]
	label_text.bbcode_text = dialog[phraseNum]["Text"]
	
	label_text.visible_characters = 0
	
	var f = File.new()
	
	while label_text.visible_characters < len(label_text.text):
		label_text.visible_characters += 1
		
		timer.start()
		yield(timer, "timeout")
	
	finished = true
	phraseNum += 1
	return
