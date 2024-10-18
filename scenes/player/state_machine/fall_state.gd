extends State


@onready var player  = $"../.."
@onready var animation_player = $"../../AnimationPlayer"


@export var air_move_speed : float 
@export var jump_buffer_time : float 

var  jump_buffer_timer = 0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func enter():
	animation_player.play("fall")
	
	#Jump Buffer
	if Input.is_action_just_pressed("jump"): 
		jump_buffer_timer = jump_buffer_time

func physics_update(delta):

	#Gravity
	if not player.is_on_floor():
		player.velocity.y += gravity * delta * 1.75
	
	#Jump Buffer
	if Input.is_action_just_pressed("jump"): 
		jump_buffer_timer = jump_buffer_time
	if player.is_on_floor() and jump_buffer_timer >= 0:
		transitioned.emit(self, "Jump")
	elif player.is_on_floor():
		transitioned.emit(self, "Land")

		
	var direction = Input.get_axis("move_left", "move_right")
	player.velocity.x = direction * air_move_speed
	
	
	jump_buffer_timer -= delta
	
	player.move_and_slide()
