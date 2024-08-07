extends Node


onready var sound_effects = $SoundEffect
onready var music = $Music

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
}

const EFFECTS = {
	player_hit = preload("res://Assets/sounds/Player_Hit.wav"),
	enemy_hit = preload("res://Assets/sounds/Enemy_Hit.wav"),
	enemy_die = preload("res://Assets/sounds/Enemy_Die.wav"),
	player_die = preload("res://Assets/sounds/Player_Hit.wav"),
	bomb_explode = preload("res://Assets/sounds/Player_Hit.wav"),
	put_bomb = preload("res://Assets/sounds/Player_Hit.wav"),
	shoot_arrow = preload("res://Assets/sounds/Player_Hit.wav"),
	thunder = preload("res://Assets/sounds/Thunder.wav"),
	select = preload("res://Assets/sounds/Select.wav"),
	open_chest = preload("res://Assets/sounds/Open_Chest_2.wav"),
	positive_2 = preload("res://Assets/sounds/Positive_2.wav"),
	positive_10 = preload("res://Assets/sounds/Positive_10.wav")
}

func play_music(sound):
	if sound != music.stream:
		music.stream = sound
		music.play()

func stop_music():
	music.stop()

func keep_music():
	music.play()

func play_effect(sound):
	for effect in sound_effects.get_children():
		effect.stream = sound
		effect.play() 
		break

func set_bus_volume(_bus_index, _value):
	AudioServer.set_bus_volume_db(_bus_index,linear2db(_value))
