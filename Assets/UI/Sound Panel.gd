extends Panel



func _ready():
	visible = false

func _on_SFX_Slider_value_changed(value):
	SoundController.set_effect_volume(value)
