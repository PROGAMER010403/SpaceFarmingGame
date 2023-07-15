extends Node2D

#@export var bullet_speed = 1000
#@export var fire_rate =.5
#var bullet = preload("res://Prefabs/bullet.tscn")
#var can_fire = true
#var bullet_instance
#var bullet_x 
#var bullet_y
#var angle_positive
#var angle_negative


func _ready():
	pass 


#func _process(delta):
#	var position = get_global_mouse_position()
#		var player_position = get_global_position()
#		var new_pos = position - player_position
#		var newer_pos = new_pos.normalized()
#		var angle = rad_to_deg(atan2(newer_pos.x, newer_pos.y))
#		print(angle)
#		if angle < 30 and angle > -30:
#			bullet_instance = bullet.instantiate()
#			bullet_instance.position = $Node2D.get_global_position()
#			bullet_instance.rotation_degrees = rotation_degrees
#			print(newer_pos)
#			bullet_instance.apply_impulse(Vector2(newer_pos.x * bullet_speed, newer_pos.y * bullet_speed ), Vector2())
#			get_tree().get_root().add_child(bullet_instance)
#			print("fired")
#			can_fire = false
#			await get_tree().create_timer(fire_rate).timeout
#			can_fire = true
#	pass
