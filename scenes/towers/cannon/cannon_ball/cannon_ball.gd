extends RigidBody2D

@onready var animation_player = $AnimationPlayer

func _on_body_entered(body):
	animation_player.play("explosion")
	set_deferred("freeze", true)

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "explosion":
		queue_free()
