extends CharacterBody2D


func bullet():
	pass

func _physics_process(delta):
	velocity.x = 0
	move_and_slide()
	

func damage_value():
	return (20)

