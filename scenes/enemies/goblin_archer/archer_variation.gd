extends Node2D

@export var shape_cast : ShapeCast2D
@export var collision_shape_2d : CollisionShape2D
@onready var attack_state = $"../StateMachine/AttackState"

# Called when the node enters the scene tree for the first time.
func _ready():
	var variation = randi_range(-5, 20)
	attack_state.projectile_fly_speed += abs(variation * 6)
	
	shape_cast.target_position.x += variation
	collision_shape_2d.shape.size.x += variation * 0.7
	collision_shape_2d.position.x += variation * 0.3
