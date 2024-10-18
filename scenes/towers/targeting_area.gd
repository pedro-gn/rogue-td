extends Area2D
class_name TargetsArea


func _ready():
	collision_layer = 0
	collision_mask = 32

func is_closer(a : CharacterBody2D, b: CharacterBody2D):
	if owner.position.distance_to(a.position) < owner.position.distance_to(b.position):
		return true
	else:
		false

func get_closest_targets():
	var targets = get_overlapping_bodies()
	targets.sort_custom(is_closer)
	return targets

func has_targets() -> bool:
	return has_overlapping_bodies()
