extends HBoxContainer

onready var en_btn = $EN_Btn
onready var pt_btn = $PT_Btn

func _on_PT_Btn_pressed():
	TranslationServer.set_locale("en")

func _on_EN_Btn_pressed():
	TranslationServer.set_locale("pt")
