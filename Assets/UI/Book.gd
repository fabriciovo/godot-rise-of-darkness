extends Control

onready var book_panel = $Book_Panel_Node

func _on_Open_Book_button_down():
	book_panel.visible = true
	visible = false
