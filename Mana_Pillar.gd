extends StaticBody2D

var disable = false
var player = null


func _ready():
	add_to_group(Global.GROUPS.STATIC)

func _input(event):
	if event.is_action_pressed("action_3") and not disable and player:
		$Sprite.frame = 0
		disable = true
		player.recover_mana()


func _on_Area2D_body_entered(body):
	if body.is_in_group(Global.GROUPS.PLAYER):
		player = body

func _on_Area2D_body_exited(body):
	if body.is_in_group(Global.GROUPS.PLAYER):
		player = null
