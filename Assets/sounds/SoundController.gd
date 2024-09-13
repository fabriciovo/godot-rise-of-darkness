extends Node


onready var sound_effects = $SoundEffect
onready var music = $Music

var fade_time = 0.3 
var volume_step = 0.05

const AUDIO_SERVER_LIST = {
	MASTER = 0,
	MUSIC = 1,
	SFX = 2
}

const MUSIC = {
	title = preload("res://Assets/sounds/Music/WaltzOfTheDeads.wav"),
	florest = preload("res://Assets/sounds/Music/florest.wav"),
	dungeon = preload("res://Assets/sounds/Music/dungeon.wav"),
	miniboss = preload("res://Assets/sounds/Music/mini boss.wav"),
	boss = preload("res://Assets/sounds/Music/boss.wav"),
	cursed_voices = preload("res://Assets/sounds/Music/Cursed_Voices.wav"),
	invasion = preload("res://Assets/sounds/Music/Invasion.wav"),
	boss_phase_1 = preload("res://Assets/sounds/Music/08 Under Attack! (LOOP).wav"),
	boss_phase_2 = preload("res://Assets/sounds/Music/04 Requiem for the Beast (LOOP).wav"),
	boss_phase_3 = preload("res://Assets/sounds/Music/03 Never Give Up (LOOP).wav"),
	ending = preload("res://Assets/sounds/Music/florest.wav"),

}

const EFFECTS = {
	player_hit = preload("res://Assets/sounds/Player_Hit.wav"),
	enemy_hit = preload("res://Assets/sounds/Character Hit 8.wav"),
	enemy_die = preload("res://Assets/sounds/Enemy_Die.wav"),
	player_die = preload("res://Assets/sounds/Player_Hit.wav"),
	bomb_explode = preload("res://Assets/sounds/Player_Hit.wav"),
	put_bomb = preload("res://Assets/sounds/Player_Hit.wav"),
	shoot_arrow = preload("res://Assets/sounds/Player_Hit.wav"),
	thunder = preload("res://Assets/sounds/Thunder.wav"),
	select = preload("res://Assets/sounds/Select.wav"),
	open_chest = preload("res://Assets/sounds/Open_Chest_2.wav"),
	positive_2 = preload("res://Assets/sounds/Positive_2.wav"),
	positive_10 = preload("res://Assets/sounds/Positive_10.wav"),
	sword_slash = preload("res://Assets/sounds/Sword_Slash.wav"),
	dash = preload("res://Assets/sounds/Dash.wav"),
	staff_heal = preload("res://Assets/sounds/Staff_Heal.wav"),
	ui_accept = preload("res://Assets/sounds/Staff_Heal.wav"),
	ui_pause = preload("res://Assets/sounds/Staff_Heal.wav"),
	ui_dialog_text = preload("res://Assets/sounds/Staff_Heal.wav"),
	ui_updgrade = preload("res://Assets/sounds/Staff_Heal.wav"),
	spawn_chest = preload("res://Assets/sounds/Staff_Heal.wav"),
	spawn_gate = preload("res://Assets/sounds/Staff_Heal.wav"),
	bear_wall_hit = preload("res://Assets/sounds/Staff_Heal.wav"),
	gate_desapear =  preload("res://Assets/sounds/Staff_Heal.wav"),
	open_gate_with_key = preload("res://Assets/sounds/Staff_Heal.wav"),
	soul_pick_up = preload("res://Assets/sounds/Item Coin 1.wav"),
	level_up = preload("res://Assets/sounds/Positive 8.wav"),
	game_over = preload("res://Assets/sounds/Negative 9.wav"),
}

func play_music(_sound):
	if _sound != music.stream:
		music.stream = _sound
		music.play()
	elif not music.playing:
		music.play()

func stop_music():
	music.stop()

func keep_music():
	music.play()

func play_effect(_sound):
	for effect in sound_effects.get_children():
		if effect.playing: continue
		effect.pitch_scale = 1
		effect.stream = _sound
		effect.play() 
		break

func play_effect_with_random_pitch(_sound, _pitch = 1.5):
	for effect in sound_effects.get_children():
		if effect.playing: continue
		effect.stream = _sound
		randomize()
		effect.pitch_scale = rand_range(0.8, _pitch)
		effect.play() 
		break

func set_bus_volume(_bus_index, _value):
	AudioServer.set_bus_volume_db(_bus_index,linear2db(_value))

func transition_to_music(_sound):
	var fade_out_time = fade_time
	var fade_in_time = 0.0
	var initial_volume = music.volume_db
	var target_volume = 0.0
	
	while fade_out_time > 0:
		fade_out_time -= volume_step
		music.volume_db = lerp(initial_volume, -13.5, 1.0 - (fade_out_time / fade_time))
		yield(get_tree().create_timer(volume_step), "timeout")
	music.stream = _sound
	music.play()
	
	while fade_in_time < fade_time:
		fade_in_time += volume_step
		music.volume_db = lerp(-13.5, target_volume, fade_in_time / fade_time)
		yield(get_tree().create_timer(volume_step), "timeout")
	music.volume_db = target_volume
