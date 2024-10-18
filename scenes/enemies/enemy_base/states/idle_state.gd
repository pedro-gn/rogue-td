extends State
class_name EnemyIdleState

@export var stop_speed : float

@export var animation_player : AnimationPlayer
@export var detection_area : Area2D
@export var attack_area : Area2D
@onready var player_node : CharacterBody2D = get_tree().root.get_node("Main/Player")
@onready var castle_node : Node2D = get_tree().root.get_node("Main/Castle")

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func enter():
	animation_player.play("idle")

func physics_update(delta):
	if not owner.is_on_floor():
		owner.velocity.y += gravity * delta
	
	if castle_node:
		transitioned.emit(self, "FollowState")
	
	owner.velocity.x = move_toward(owner.velocity.x, 0, stop_speed)
	owner.move_and_slide()
