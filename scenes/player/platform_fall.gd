extends Node2D

@onready var player : CharacterBody2D = $".."
@onready var ray_cast_2d = $RayCast2D



func _process(delta):
	if ray_cast_2d.is_colliding():
		if Input.is_action_just_pressed("platform_fall") and (ray_cast_2d.get_collider().name == "Platform" or ray_cast_2d.get_collider().name == "Platform2"):
			if player.is_on_floor():
				player.position.y += 1
