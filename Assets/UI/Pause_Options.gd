extends Control

onready var pause_conatainer = $Pause_Button_Container

func _ready():
	pause_conatainer.grab_focus()
