extends Area2D

var spikes = false
var player_damage = false
onready var body = get_parent().get_parent().get_node("Player")



func _ready():
	$Timer.start(2)

func _process(_delta):
	if Global.stop: return
	if spikes:
		$Sprite.frame = 28
	else:
		$Sprite.frame = 27
	if body:
		if overlaps_body(body) and spikes and not player_damage:
			body.damage(3)
			player_damage = true


func _on_Timer_timeout():
	spikes = !spikes
	player_damage = false


