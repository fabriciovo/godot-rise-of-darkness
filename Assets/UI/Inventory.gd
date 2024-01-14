extends Control

func _ready():
	$NinePatchRect/GridContainer.set_focus_mode(Control.FOCUS_ALL)
	$NinePatchRect/GridContainer.grab_focus()
