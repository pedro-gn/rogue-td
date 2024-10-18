extends TowerBase
@onready var targets_area = $TargetsArea
@onready var animation_player = $AnimationPlayer
@onready var shoot_point : Marker2D = $Flipper/TopPivot/ShootPoint
@onready var top = $Flipper/TopPivot

var current_target

func _physics_process(delta):
	
	if targets_area.has_targets():
		var targets = targets_area.get_closest_targets()
		current_target = targets[0]
		animation_player.play("shoot")
		top.look_at(current_target.global_position)


func shoot():
	var projectile_instance : RigidBody2D = tower_info_res.projectile.projectile_scene.instantiate()
	projectile_instance.global_position = shoot_point.global_position
	projectile_instance.rotation = shoot_point.global_position.direction_to(current_target.global_position).angle()
	projectile_instance.apply_impulse(shoot_point.global_position.direction_to(current_target.global_position) * tower_info_res.projectile.projectile_fly_speed)
	get_tree().root.add_child(projectile_instance)
