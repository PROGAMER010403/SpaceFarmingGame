extends CharacterBody2D

@export var playerSpeed = 350
<<<<<<< Updated upstream
=======
@export var bullet_speed = 2500
var bullet_speed_2 = bullet_speed
var bullet = preload("res://Prefabs/bullet.tscn")
var can_fire = true
var current_health : int
var max_health = 100
var fireRate = 0.1
var turned = false
var bullet_instance
>>>>>>> Stashed changes


func _physics_process(delta):
	move_and_slide()
<<<<<<< Updated upstream

=======
	_update_current_health()
	fire()
	if $Sprite2D.flip_h == true:
		turned = true
	else:
		turned = false
	

func fire():
	if Input.is_action_pressed("Mouse_Left_Click") and can_fire:
		bullet_instance = bullet.instantiate()
		if turned:
			bullet_instance.position = $Node2D.position
			bullet_instance.apply_impulse(Vector2(-bullet_speed, 0), Vector2())
			add_child(bullet_instance)
			can_fire = false
			await get_tree().create_timer(fireRate).timeout
			can_fire = true
		else:
			bullet_instance.position = $Node2D2.position
			bullet_instance.apply_impulse(Vector2(bullet_speed, 0), Vector2())
			add_child(bullet_instance)
			can_fire = false
			await get_tree().create_timer(fireRate).timeout
			can_fire = true
			
>>>>>>> Stashed changes

func _input(event):
	var inputDirection : Vector2
	
	#Check for input direction and set an equivalent vector for it.
	if Input.is_action_pressed("Key_Left") && Input.is_action_pressed("Key_Right"):
		inputDirection = Vector2 (0, 0)
		$Sprite2D.speed_scale = 0
		$Sprite2D.frame = 0
	elif Input.is_action_pressed("Key_Right"):
		inputDirection = Vector2 (1, 0)
		$Sprite2D.flip_h = false
		$Sprite2D.speed_scale = 1
		
	elif Input.is_action_pressed("Key_Left"):
		inputDirection = Vector2 (-1, 0)
		$Sprite2D.flip_h = true
		$Sprite2D.speed_scale = 1
	else:
		$Sprite2D.speed_scale = 0
		$Sprite2D.frame = 0
	velocity = inputDirection * playerSpeed
