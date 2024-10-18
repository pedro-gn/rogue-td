extends Marker2D
class_name SpriteFlipper

@export var character_body : CharacterBody2D

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if character_body:
		if character_body.velocity.x > 0:
			scale.x = 1
		elif character_body.velocity.x < 0:
			scale.x = -1
