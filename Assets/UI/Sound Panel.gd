extends Panel



func _ready():
	SoundController.set_effect_volume(SoundController.sfx_value)
	SoundController.set_music_volume(SoundController.music_value)

func _process(delta):
	if get_tree().current_scene.name == "Title_Scene":
		var viewport = get_viewport_rect().size
		var x = viewport.x / 2
		var y = viewport.y / 2
		set_position(Vector2(x / 1.9,y / 2))
	else:
		set_position(Vector2(11,81))

func _on_SFX_Slider_value_changed(value):
	SoundController.set_effect_volume(value)

func _on_Music_Slider_value_changed(value):
	SoundController.set_music_volume(value)
