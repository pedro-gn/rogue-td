extends State

@onready var animation_player = $"../../AnimationPlayer"

func enter():
	animation_player.play("attack")
	
func _on_animation_player_animation_finished(anim_name):
	if anim_name == "attack":
		if Input.is_action_pressed("mouse_left"):
			animation_player.play("attack")
		else:
			transitioned.emit(self, "Idle")
