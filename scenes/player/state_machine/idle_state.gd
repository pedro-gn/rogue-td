extends State


@onready var player = $"../.."
@onready var animation_player = $"../../AnimationPlayer"

@export var stop_speed : float

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func enter():
	animation_player.play("idle")
	
func physics_update(delta):
	
	#Gravity
	if not player.is_on_floor():
		player.velocity.y += gravity * delta
	
	var direction = Input.get_axis("move_left", "move_right")
	
	#if Input.is_action_just_pressed("mouse_left"):
		#transitioned.emit(self, "Attack")
	if Input.is_action_just_pressed("jump"):
		transitioned.emit(self, "Jump")
	elif direction != 0 :
		transitioned.emit(self, "Walk")
	elif player.velocity.x != 0:
		transitioned.emit(self, "Walk")
		
	player.velocity.x = move_toward(player.velocity.x, 0, stop_speed)
	
	player.move_and_slide()
