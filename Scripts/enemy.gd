extends CharacterBody2D

@export var speed = 6000
@export var max_health = 100
@export var damage_to_player = 20

var current_health : int

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
	$healthbar.max_value = max_health
	current_health = max_health
	
	if global_position.x <= -3:
		scale.x = -1.5
		$healthbar.scale.x = -1

func _physics_process(delta):
	if global_position.x >= 3:
		velocity.x = -speed * delta
	elif global_position.x <= -3:
		velocity.x = speed * delta
	if global_position.x >= -5 && global_position.x <= 5:
		queue_free()
	
	_update_current_health()
	move_and_slide()
	laser_damage()


func _update_current_health():
	var current_healthbar = $healthbar
	current_healthbar.value = current_health
	if current_health >= max_health:
		current_healthbar.visible = false
	else:
		current_healthbar.visible = true
	if current_health <= 0:
		queue_free()


func laser_damage():
	if lasered:
		current_health -= 1
		$laser_timer.start()
		slower()


func trap_damage(trap_dmg):
	if trapped:
		current_health -= trap_dmg
		slower()
		$trap_timer.start()


func damage(dmg):
		current_health -= dmg
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


func _on_timer_timeout():
	speed = speed_s 


func _on_player_detector_body_entered(body):
	if body.name == "Player":
		is_attacking = true
		speed = 0
		anim_player()




func anim_player():
	if is_attacking == false and animation_finished == true:
		$AnimatedSprite2D.play("walking_anim")
	else:
		$AnimatedSprite2D.play("attack_anim")
		animation_finished = false


func _on_player_detector_body_exited(body):
	if body.name == "Player":
		is_attacking = false
		speed = speed_s
		anim_player()


func _on_animated_sprite_2d_animation_finished():
	animation_finished = true
	anim_player()


func _on_laser_timer_timeout():
	speed = speed_s


func _on_trap_timer_timeout():
	speed = speed_s


func _on_player_detector_area_entered(area):
	if area.name == "HumanPodArea2D":
		area.get_parent().destroyed()
		queue_free()
