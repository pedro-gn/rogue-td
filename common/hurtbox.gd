extends Area2D
class_name HurtBox
signal hit_taken(damage_stats : DamageStats, damage_position : Vector2)

var last_hit_taken_pos : Vector2

func _ready():
	connect("area_entered", self._on_area_entered)
	
func _on_area_entered(area):
	if area is HitBox:
		hit_taken.emit(area.damage_stats, area.global_position)
		last_hit_taken_pos = area.global_position
