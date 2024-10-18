extends RigidBody2D

@onready var ray_cast_2d = $RayCast2D

func _on_hit_box_area_entered(area):
	pass

func _integrate_forces(state):
	if ray_cast_2d.is_colliding():
		call_deferred("queue_free")
	else :
		rotation = linear_velocity.angle()
