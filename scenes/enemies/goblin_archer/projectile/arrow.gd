extends RigidBody2D
@onready var ray_cast_2d = $RayCast2D
@onready var hit_box_shape = $HitBox/CollisionShape2D

func _integrate_forces(state):
	if ray_cast_2d.is_colliding():
		set_deferred("freeze", true)
		hit_box_shape.set_deferred("disabled", true)
		call_deferred("queue_free")
	else :
		rotation = linear_velocity.angle()
