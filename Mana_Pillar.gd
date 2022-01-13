extends StaticBody2D

var disable = false
var player = false

func _ready():
	add_to_group(Global.GROUPS.STATIC)

func _input(event):
	if event.is_action_pressed("action_3") and not disable and player:
		recover_mana()

func recover_mana():
	$Sprite.frame = 0
	PlayerControll.set_mp(PlayerControll.max_mp)
	disable = true

func _on_Area2D_body_entered(body):
	if body.is_in_group(Global.GROUPS.PLAYER):
		player = true

func _on_Area2D_body_exited(body):
	if body.is_in_group(Global.GROUPS.PLAYER):
		player = false
