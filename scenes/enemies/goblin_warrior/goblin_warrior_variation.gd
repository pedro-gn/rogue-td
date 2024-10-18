extends Node2D
@export var attack_area_collision_shape : CollisionShape2D
@export var hit_box_collision_shape : CollisionShape2D
# Called when the node enters the scene tree for the first time.
func _ready():
	var attack_area_variation = randi_range(-5, 5)
	
	attack_area_collision_shape.shape.size.x += attack_area_variation * 0.7
	attack_area_collision_shape.position.x += attack_area_variation * 0.3
	
	hit_box_collision_shape.shape.size.x += attack_area_variation * 0.7
	hit_box_collision_shape.position.x += attack_area_variation * 0.3
