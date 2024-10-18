extends TowerBase

@export var shoot_point : Node2D
@export_enum("0", "1") var projectile_trajectory_type : String
@export var targets_area : TargetsArea
@onready var fire_rate_timer = $FireRateTimer
@onready var animation_player = $AnimationPlayer
@onready var cannon_top_pivot = $Flipper/CannonTopPivot
@onready var flipper = $Flipper

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var can_shoot = true
var current_target : CharacterBody2D
var angle = 0


func _physics_process(delta):
	if targets_area.has_targets():
		var targets = targets_area.get_closest_targets()
		current_target = targets[0]
		
		#Flip cannon Sprites
		if targets[0].global_position.x < global_position.x:
			flipper.scale.x = -1 
		else :
			flipper.scale.x = 1
		
		var g = gravity
		var v = tower_info_res.projectile.projectile_fly_speed
		var x = shoot_point.global_position.x - current_target.global_position.x
		var y = shoot_point.global_position.y - current_target.global_position.y
		
		
		#Calculate the angle and see if the target is in angle range
		angle = calculate_projectile_angle(g, v, x, y)[int(projectile_trajectory_type)]
		if angle > deg_to_rad(-40) and angle < deg_to_rad(40):
			if x > 0 :
				cannon_top_pivot.rotation = -1 * angle
			else:	
				cannon_top_pivot.rotation = angle

			if can_shoot :
				animation_player.play("shoot")
				can_shoot = false
				fire_rate_timer.start()

func calculate_projectile_angle(g, v, x, y):
	var sqrt_result = sqrt(pow(v, 4) -  g*(g*pow(x,2) + 2*y*pow(v,2))) 
	var formula_result1 = atan( (pow(v,2) + sqrt_result) / (g*x) )
	var formula_result2 = atan( (pow(v,2) - sqrt_result) / (g*x) )
	return [formula_result1, formula_result2]
	
func shoot():
	#Instanciate the projectile
	var projectile_instance : RigidBody2D = tower_info_res.projectile.projectile_scene.instantiate()
	projectile_instance.global_position = shoot_point.global_position
	get_tree().root.add_child(projectile_instance)
	
	#Vê o lado da torre
	if (shoot_point.global_position.x - current_target.global_position.x) > 0 :
		projectile_instance.apply_impulse(-1*Vector2.RIGHT.rotated(angle) * tower_info_res.projectile.projectile_fly_speed)
	else :
		projectile_instance.apply_impulse(Vector2.RIGHT.rotated(angle) * tower_info_res.projectile.projectile_fly_speed)
	
	
func _on_fire_rate_timer_timeout():
	can_shoot = true
