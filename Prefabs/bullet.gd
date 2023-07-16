extends RigidBody2D

func damage_value():
	return(20)
	
func bullet():
	pass


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	pass 
