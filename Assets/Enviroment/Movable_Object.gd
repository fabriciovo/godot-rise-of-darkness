extends KinematicBody2D

var move = Vector2()



func _physics_process(delta):
	move = move_and_slide (move, Vector2(0,0), false, 4, PI/4, false).normalized()




