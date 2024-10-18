extends State
class_name EnemyAttackState
@export var animation_player : AnimationPlayer
@export var attack_timer : Timer
@export var attack_area : Area2D
@export var stop_speed : float = 5
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var following_target : Node2D

var can_attack = true

func enter():
	if can_attack :
		attack()
		can_attack = false
		attack_timer.start()
		

func physics_update(delta):
	if not owner.is_on_floor():
		owner.velocity.y += gravity * delta
	
	owner.velocity.x = move_toward(owner.velocity.x, 0, stop_speed)
	owner.move_and_slide()
	
	if can_attack :
		attack()
		can_attack = false
		attack_timer.start()
	
	if not await animation_player.animation_finished:
		return
	
	if attack_area.has_overlapping_bodies():
		pass
	else:
		call_deferred("emit_signal", "transitioned", self, "IdleState")
		


func attack():
	animation_player.play("attack")
	
	
func _on_attack_timer_timeout():
	can_attack = true
