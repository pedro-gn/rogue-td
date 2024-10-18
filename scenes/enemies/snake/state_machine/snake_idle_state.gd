extends State


@export var enemy : CharacterBody2D
@export var stop_speed : float

@onready var animation_player = $"../../AnimationPlayer"
@onready var player_node : CharacterBody2D = get_tree().root.get_node("Main/Player")
@onready var detection_area = $"../../Area2D"



var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func enter():
	animation_player.play("idle")

	
func physics_update(delta):
	if not enemy.is_on_floor():
		enemy.velocity.y += gravity * delta
	
	if detection_area.has_overlapping_bodies():
		transitioned.emit(self, "FollowState")
	
	
	enemy.velocity.x = move_toward(enemy.velocity.x, 0, stop_speed)
	enemy.move_and_slide()
