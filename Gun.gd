extends Sprite2D

@export var bullet_speed = 1000
@export var fire_rate =.5
var bullet = preload("res://Prefabs/bullet.tscn")
var can_fire = true
var bullet_instance
var mouse_pos
var angle : float
var angle_positive = true
var angle_negative = false
var newer_pos
var player_position
var new_pos

func _process(delta):
	mouse_pos = get_global_mouse_position()
	player_position = get_global_position()
	new_pos = mouse_pos - player_position
	newer_pos = new_pos.normalized()
	angle = rad_to_deg(atan2(newer_pos.x, newer_pos.y))
	angle_checker()
	angle_checker_2()
	
	
	
	if Input.is_action_pressed("Mouse_Left_Click") and can_fire:
			bullet_instance = bullet.instantiate()
			bullet_instance.position = $Node2D.get_global_position()
			bullet_instance.rotation_degrees = rotation_degrees
			print(newer_pos)
			bullet_instance.apply_impulse(Vector2(newer_pos.x * bullet_speed, newer_pos.y * bullet_speed ), Vector2())
			get_tree().get_root().add_child(bullet_instance)
			print("fired")
			can_fire = false
			await get_tree().create_timer(fire_rate).timeout
			can_fire = true
			


func angle_checker():
	if 120 > angle and 90 < angle:
		look_at(get_global_mouse_position())
	elif -120 < angle and -90 > angle:
		look_at(get_global_mouse_position())
	
		
func angle_checker_2():
	if 180 > angle and 120 < angle:
		newer_pos.x = 1
		newer_pos.y = 0
		print("upper_pos")
	elif 60 > angle and 0 < angle:
		newer_pos.x = 1
		newer_pos.y = 0
		print("lower pos")
	elif -120 > angle  and -180 < angle:
		newer_pos.x = -1
		newer_pos.y = 0
		print("upper neg")
	elif -60 < angle and 0 > angle:
		newer_pos.x = -1
		newer_pos.y = 0
		print("lower neg")
  


