extends Button

func _process(_delta):
	if PlayerControll.points > 0:
		visible = true
		disabled = false
	else:
		visible = false
		disabled = true


func _on_Upgrade_pressed():
	Ui.show_hidden_panels()
