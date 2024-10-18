extends State

@onready var player = $"../.."
@onready var animation_player = $"../../AnimationPlayer"

@export var jump_velocity : float
@export var coyot_time : float
@export var air_move_speed : float

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var coyot_timer = 0
var looking_direction = 1

#Physics process is used just to keep track of coyot time because it must count time even if in another state 
func _physics_process(delta):
	
	if player.is_on_floor():
		coyot_timer = coyot_time
	else :
		coyot_timer -= delta
	
	
func enter():
	animation_player.play("jump")
	
	if coyot_timer >= 0 and player.velocity.y >= 0:
		player.velocity.y = jump_velocity



func physics_update(delta):	
	#Gravity
	if not player.is_on_floor():
		player.velocity.y += gravity * delta
	
	#State Chcek
	if !player.is_on_floor() and player.velocity.y >= 0 :
		transitioned.emit(self, "Fall")
	if player.is_on_floor() and player.velocity.x != 0:
		transitioned.emit(self, "Walk")
	elif player.is_on_floor() and player.velocity.x == 0:
		transitioned.emit(self, "Idle")
	
	#Moving on air
	var direction = Input.get_axis("move_left", "move_right")
	player.velocity.x = direction * air_move_speed

	#If not pressing jump falls early
	if not Input.is_action_pressed("jump") and player.velocity.y < 0:
		player.velocity.y += gravity * delta
	

	player.move_and_slide()
