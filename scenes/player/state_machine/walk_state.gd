extends State

@onready var player = $"../.."
@onready var animation_player = $"../../AnimationPlayer"

@export var speed : float

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func enter():
	animation_player.play("walk")


func physics_update(delta):
	animation_player.play("walk")
	#Gravity
	if not player.is_on_floor():
		player.velocity.y += gravity * delta
		
	var direction = Input.get_axis("move_left", "move_right")

	if Input.is_action_just_pressed("jump"):
		transitioned.emit(self, "Jump")
	elif direction == 0 :
		transitioned.emit(self, "Idle")
	
	player.velocity.x = direction * speed

	player.move_and_slide()
