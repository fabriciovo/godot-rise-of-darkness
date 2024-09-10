class_name Hero_Projectile extends Arrow


func _init():
	frame = 0

func _process(_delta):
	rotation_degrees -= 23
