extends EnemyAttackState

@export var projectile_scene : PackedScene
@export var projectile_fly_speed : float
@export var shoot_point : Marker2D
@onready var shape_cast_2d = $"../../SpriteFlipper/ShapeCast2D"

func attack():
	animation_player.play("attack")

func calculate_projectile_angle(g, v, x, y):
	var sqrt_result = sqrt(pow(v, 4) -  g*(g*pow(x,2) + 2*y*pow(v,2))) 
	var formula_result1 = atan( (pow(v,2) + sqrt_result) / (g*x) )
	var formula_result2 = atan( (pow(v,2) - sqrt_result) / (g*x) )
	return [formula_result1, formula_result2]

func spawn_arrow():
	if not attack_area.has_overlapping_bodies():
		return
		
	if not shape_cast_2d.is_colliding():
		return
		
	var target = shape_cast_2d.get_collision_point(0)
	
	#adjust the target
	if target.x < shoot_point.global_position.x:
		target.x += randi_range(-15, -25)
	else:
		target.x += randi_range(5, 15)

	var g = gravity
	var v = projectile_fly_speed
	var x = shoot_point.global_position.x - target.x
	var y = shoot_point.global_position.y - target.y
	
	var angle = calculate_projectile_angle(g, v, x, y)[0]
	
	var arrow : RigidBody2D = projectile_scene.instantiate()
	if x > 0 :
		arrow.apply_impulse(-1*Vector2.RIGHT.rotated(angle)*projectile_fly_speed)
		arrow.rotate(angle)
	else:
		arrow.apply_impulse(Vector2.RIGHT.rotated(angle)*projectile_fly_speed)
		arrow.rotate(angle)
		
	arrow.global_position = shoot_point.global_position
	get_tree().root.add_child(arrow)
