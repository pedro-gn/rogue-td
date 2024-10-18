extends Node
class_name HealthSystem

signal died

@export var health_stats : HealthStats
@export var health_bar : TextureProgressBar
var current_health : float

func _ready():
	current_health = health_stats.max_health
	if health_bar :
		health_bar.max_value = health_stats.max_health
		health_bar.value = health_stats.max_health


func take_damage(damage_stats : DamageStats):
	current_health -= damage_stats.base_damage
	if health_bar:
		health_bar.value = current_health
	if current_health <= 0:
		die()
		
func die():
	died.emit()
