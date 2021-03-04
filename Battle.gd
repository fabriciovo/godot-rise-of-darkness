extends Node

onready var enemy = $Enemy

func _on_SwordButton_pressed():
	enemy.hp -= 4
	print("Attack!")
