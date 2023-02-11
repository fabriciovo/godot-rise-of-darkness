extends Node

onready var sound_effects = $SoundEffect

const EFFECTS = {
	player_hit = preload("res://Assets/sounds/Player_Hit.wav"),
	enemy_hit = preload("res://Assets/sounds/Enemy_Hit.wav"),
	enemy_die = preload("res://Assets/sounds/Enemy_Die.wav"),
}

func play_music(sound):
	pass

func play_effect(sound):
	for effect in sound_effects.get_children():
		effect.stream = sound
		effect.play() 
		break

func set_music_volume():
	pass

func set_effect_volume():
	pass


func mute_effect_volume():
	pass

func mute_music_volume():
	pass
	
