extends State
class_name HitState

@export var stop_speed : float
@export var default_state : State

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func enter():
	owner.move_and_slide()
	
func physics_update(delta):
	
	if owner.is_on_floor():
		transitioned.emit(self, default_state.name)
	else :
		owner.velocity.y += gravity * delta
		
	owner.velocity.x = move_toward(owner.velocity.x, 0, stop_speed)
	owner.move_and_slide()
