extends Panel



func _ready():
	visible = false
	SoundController.set_effect_volume(0)
	SoundController.set_music_volume(0)
	

func _on_SFX_Slider_value_changed(value):
	SoundController.set_effect_volume(value)


func _on_Music_Slider_value_changed(value):
	SoundController.set_music_volume(value)
