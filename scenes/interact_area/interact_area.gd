extends Area2D
signal interacted()

@onready var key_sprite = $keySprite

func _ready():
	collision_layer = 0
	collision_mask = 16

func _physics_process(delta):
	if monitoring and has_overlapping_bodies():
		key_sprite.show()
		if Input.is_action_just_pressed("interact") :
			interacted.emit()
	else:
		key_sprite.hide()
