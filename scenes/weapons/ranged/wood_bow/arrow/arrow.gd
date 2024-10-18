extends RigidBody2D

@onready var ray_cast_2d = $RayCast2D
@onready var hit_box_shape = $HitBox/CollisionShape2D
@onready var hit_box = $HitBox

func _ready():
	hit_box.area_entered.connect(_on_area_entered)
	
func _on_area_entered(area):
	call_deferred("queue_free")

func _integrate_forces(state):
	
	
	if ray_cast_2d.is_colliding():
		if ray_cast_2d.get_collider().is_in_group("OneWay"):
			return
		
		set_deferred("freeze", true)
		hit_box_shape.set_deferred("disabled", true)
	else :
		rotation = linear_velocity.angle()


func _on_timer_timeout():
	call_deferred("queue_free")
