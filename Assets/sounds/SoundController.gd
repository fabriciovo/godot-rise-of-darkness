extends Node


onready var sound_effects = $SoundEffect
onready var music = $Music

const MUSIC = {
	title = preload("res://Assets/sounds/Music/title.wav"),
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
}

func play_music(sound):
	if sound != music.stream:
		music.stream = sound
		music.play()

func play_effect(sound):
	for effect in sound_effects.get_children():
		effect.stream = sound
		effect.play() 
		break

func set_music_volume(value):
	music.volume_db = value

func set_effect_volume(value):
	for effect in sound_effects.get_children():
		effect.volume_db = value


func mute_effect_volume():
	pass

func mute_music_volume():
	pass
	
