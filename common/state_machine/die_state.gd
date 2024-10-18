extends State
class_name DieState


@export var die_delay : float = 1
@export var die_audio_player : AudioStreamPlayer2D
@export var hurt_box : HurtBox
@export var hit_box : HitBox
@export var die_particles : GPUParticles2D

var die_delay_timer

func enter():
	die_delay_timer = die_delay
	die_audio_player.play()
	die_particles.emitting = true
	hurt_box.set_deferred("monitoring", false)
	hit_box.set_deferred("monitorable", false)
	owner.hide()
	
func physics_update(delta):
	die_delay_timer -= delta
	if die_delay_timer <= 0 :
		owner.queue_free()
