extends State
class_name EnemyFollowState

@export var max_follow_speed : float

@export var animation_player : AnimationPlayer
@export var detection_area : Area2D
@export var attack_area : Area2D
@onready var player_node : CharacterBody2D = get_tree().root.get_node("Main/Player")
@onready var castle_node : Node2D = get_tree().root.get_node("Main/Castle")

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var following_target : Node2D

func _ready():
	detection_area.area_entered.connect(_on_detection_area_area_entered)
	detection_area.area_exited.connect(_on_detection_area_area_exited)
	following_target = castle_node

func enter():
	animation_player.play("walk")

func physics_update(delta):
	if not castle_node:
		transitioned.emit(self, "IdleState")
		return
		
	if not owner.is_on_floor():
		owner.velocity.y += gravity * delta
	var direction
	if following_target.position.x > owner.position.x:
		direction = 1
	else : 
		direction = -1
	owner.velocity.x = move_toward(owner.velocity.x, max_follow_speed * direction, 5 )
	
	if attack_area.has_overlapping_bodies():
		transitioned.emit(self, "AttackState")
	
	owner.move_and_slide()


func _on_detection_area_area_entered(area):
	if area.owner == player_node :
		following_target = player_node
	else:
		following_target = castle_node

func _on_detection_area_area_exited(area):
	if area.owner == player_node :
		following_target = castle_node
