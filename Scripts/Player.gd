extends CharacterBody2D

@export var playerSpeed = 350


func _physics_process(delta):
	move_and_slide()


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
