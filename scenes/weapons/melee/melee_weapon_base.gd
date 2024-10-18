extends WeapomBase
class_name MeleeWeaponBase

@export var hit_box : HitBox

func activate_hitbox():
	hit_box.get_child(0).disabled = false
	
func deactivate_hitbox():
	hit_box.get_child(0).disabled = true
	
