extends Panel

func _ready():
	SoundController.set_effect_volume(-40)
	SoundController.set_music_volume(-40)

func _on_SFX_Slider_value_changed(value):
	SoundController.set_effect_volume(value)

func _on_Music_Slider_value_changed(value):
	SoundController.set_music_volume(value)
