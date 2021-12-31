extends KinematicBody2D

export (String) var ID


func _ready():
	$Beholder_Animation.play("Beholder_anim")
	add_to_group("Enemy")




func _on_Body_area_entered(area):
	if area.name == "ActionArea":
		pass


