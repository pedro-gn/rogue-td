extends State

@export var enemy : CharacterBody2D
@export var max_follow_speed : float

@onready var animation_player = $"../../AnimationPlayer"
@onready var player_node : CharacterBody2D = get_tree().root.get_node("Main/Player")
@onready var detection_area = $"../../Area2D"

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func enter():
	animation_player.play("walk")
	
func physics_update(delta):
	if not detection_area.has_overlapping_bodies():
		transitioned.emit(self, "IdleState")
		
	if not enemy.is_on_floor():
		enemy.velocity.y += gravity * delta

	var direction
	if player_node.position.x > enemy.position.x:
		direction = 1
	else : 
		direction = -1
		
	enemy.velocity.x = move_toward(enemy.velocity.x, max_follow_speed * direction, 5 )
	
	enemy.move_and_slide()
