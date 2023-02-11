extends Panel



func _ready():
	visible = false
	SoundController.set_effect_volume(100)
#	SoundController.set_music_volume(100)
	

func _on_SFX_Slider_value_changed(value):
	SoundController.set_effect_volume(value)
