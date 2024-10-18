extends RangedWeaponBase

@onready var animation_player = $AnimationPlayer


func shoot(angle : float):
	animation_player.play("shoot")
	var projectile_instance : RigidBody2D = projectile_res.projectile_scene.instantiate()
	projectile_instance.rotation = angle
	projectile_instance.global_position = global_position
	projectile_instance.apply_impulse(projectile_res.projectile_fly_speed * Vector2.RIGHT.rotated(angle))
	get_tree().root.add_child(projectile_instance)
