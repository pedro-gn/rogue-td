extends Node
class_name HitSystem

@export var hit_flash_animation_player : AnimationPlayer
@export var hit_audio_stream_player : AudioStreamPlayer2D

func take_hit(damage_stats : DamageStats, damage_pos : Vector2):
	hit_flash_animation_player.play("hit_flash")
	hit_audio_stream_player.play_hit_sound()
	
	if damage_pos.x >= owner.global_position.x: 
		owner.velocity = Vector2(damage_stats.knockback.x * -1, damage_stats.knockback.y)
	else :
		owner.velocity = Vector2(damage_stats.knockback.x , damage_stats.knockback.y)

	owner.move_and_slide()
