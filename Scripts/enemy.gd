extends CharacterBody2D


@export var speed = 200
@export var health = 100
@export var damage_to_player = 20
var takes_damage = false
var trapped = false
var is_attacked = false
var slowed = false
var is_attacking = false
var lasered = false
var animation_finished = true
var speed_s = speed


func _ready():
	add_to_group("enemies")
	anim_player()
	
	
func _physics_process(delta):
	
	
	velocity.x = -speed
	_update_health()
	move_and_slide()
	laser_damage()
	
	


func _update_health():
	var healthbar = $healthbar
	healthbar.value = health
	if health >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true
		
func laser_damage():
	if lasered:
		health -= 1
		$laser_timer.start()
		slower()

func trap_damage(trap_dmg):
	if trapped:
		health -= trap_dmg
		slower()
		$trap_timer.start()
	

func damage(dmg):
		health -= dmg
		print("dmg taken")
		slower()
		$Timer.start()
		
func slower():
	if lasered:
		speed = speed * .2
	elif trapped:
		speed = 0
	else:
		speed = speed * .8
	
	
func enemy():
	pass

func dmg_to_player():
	return(damage_to_player)


func _on_bullet_detector_body_entered(body):
	if body.has_method("bullet"):
		var damageAmount = body.damage_value()
		damage(damageAmount)		
		print("b")
	pass 


func _on_timer_timeout():
	speed = speed_s
	pass 


func _on_player_detector_body_entered(body):
	if body.has_method("android"):
		is_attacking = true	
		speed = 0
		anim_player()
		
	pass 
	


func anim_player():
	if is_attacking == false and animation_finished == true:
		$AnimatedSprite2D.play("walking_anim")
	else:
		$AnimatedSprite2D.play("attack_anim")
		animation_finished = false
		
	
	
func _on_player_detector_body_exited(body):
	if body.has_method("android"):
		is_attacking = false
		speed = speed_s
		anim_player()
	pass 



	









func _on_animated_sprite_2d_animation_finished():
	print("done")
	animation_finished = true
	anim_player()
	pass 


func _on_laser_timer_timeout():
	speed = speed_s
	pass 


func _on_trap_timer_timeout():
	speed = speed_s
	pass 
