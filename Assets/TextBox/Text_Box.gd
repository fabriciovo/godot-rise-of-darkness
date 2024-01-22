class_name Text_Box extends MarginContainer
 
const MAX_WIDTH = 224

var dialog_name = ""
export(float) var textSpeed = 0.05

onready var label_name = $MarginContainer/VBoxContainer/Name
onready var label_text = $MarginContainer/VBoxContainer/Label
onready var timer = $Timer

var dialog
var phraseNum = 0
var finished = false
var dialog_path = "res://Assets/Dialogs/"
 
func _ready():
	visible = false

func start_dialog():
	visible = true
	dialog_path += dialog_name
	print(dialog_path)
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
	if rect_size.x > 224:
		rect_size.x = 224
 
func getDialog():
	var f = File.new()
	assert(f.file_exists(dialog_path), "File path does not exist")
	
	f.open(dialog_path, File.READ)
	var json = f.get_as_text()
	
	var output = parse_json(json)
	
	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return []
 
func nextPhrase():
	if phraseNum >= len(dialog):
		visible = false
		return
	finished = false
	label_name.text = dialog[phraseNum]["Name"]
	label_text.text = dialog[phraseNum]["Text"]
	label_text.visible_characters = 0
	while label_text.visible_characters < len(label_text.text):
		label_text.visible_characters += 1
		
		timer.start()
		yield(timer, "timeout")
	
	finished = true
	phraseNum += 1
	return
