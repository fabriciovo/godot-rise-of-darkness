extends Enemy_Projectile


func _ready():
	$AnimationPlayer.stop()

func _process(_delta):
	$Sprite.rotation_degrees += 3
