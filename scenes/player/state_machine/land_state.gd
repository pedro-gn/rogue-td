extends State


@onready var player  = $"../.."
@onready var animation_player = $"../../AnimationPlayer"


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var anim_fineshed = false 

func enter():
	animation_player.play("land")
	anim_fineshed = false
	
func physics_update(delta):
	player.move_and_slide()	


			
func _on_animation_player_animation_finished(anim_name):
	if anim_name == "land":
		if player.is_on_floor() and player.velocity.x != 0:
			transitioned.emit(self, "Walk")
		elif player.is_on_floor() and player.velocity.x == 0:
			transitioned.emit(self, "Idle")
		elif !player.is_on_floor():
			transitioned.emit(self, "Fall")
