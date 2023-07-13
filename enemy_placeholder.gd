extends Node2D


func _physics_process(delta):
	if global_position.x >= 3:
		position.x -= 500 * delta
	elif global_position.x <= -3:
		position.x += 500 * delta
	if global_position.x >= -5 && global_position.x <= 5:
		queue_free()
