extends Panel

func _ready():
	$SFX/SFX_Slider.grab_focus()
	SoundController.set_bus_volume(SoundController.AUDIO_SERVER_LIST.MUSIC, 1)
	SoundController.set_bus_volume(SoundController.AUDIO_SERVER_LIST.SFX, 1)

func _on_SFX_Slider_value_changed(_value):
		SoundController.set_bus_volume(SoundController.AUDIO_SERVER_LIST.SFX, _value)

func _on_Music_Slider_value_changed(_value):
		SoundController.set_bus_volume(SoundController.AUDIO_SERVER_LIST.MUSIC, _value)
