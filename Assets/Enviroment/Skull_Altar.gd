extends StaticBody2D

export var altar_number = 0

func _ready():
	if Global.skull_altar[altar_number]:
		$Sprite.frame = 8
	else: 
		$Sprite.frame = 0


func _input(_event):
	if _event.is_action_pressed("action_3"):
		if not Global.skull_altar[altar_number]:
			$Sprite.frame = 8
