extends Control

onready var btn_options = $Pause_Button_Container/Options

func _ready():
	btn_options.grab_focus()
