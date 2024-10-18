extends Area2D
signal collected(item : AbstractItem)


@export var collect_speed : float = 150
@export var collect_distance : float = 2

func _process(delta):
	if has_overlapping_bodies():
		for collectible in get_overlapping_bodies():
			collectible.global_position += collectible.global_position.direction_to(owner.global_position) * collect_speed * delta
			if collectible.global_position.distance_to(owner.global_position) <= collect_distance:
				collected.emit(collectible)
				collectible.queue_free()
