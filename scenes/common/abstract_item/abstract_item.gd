extends RigidBody2D
class_name AbstractItem

@export var sprite_2d : Sprite2D

var item : Item : 
	set(new_item):
		item = new_item
		sprite_2d.texture = item.texture

func _ready():
	apply_impulse(Vector2(randf_range(-50,50),-200))
