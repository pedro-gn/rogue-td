extends Node2D
signal die()

@onready var hurt_box = $HurtBox
@onready var health_system = $HealthSystem

# Called when the node enters the scene tree for the first time.
func _ready():
	hurt_box.hit_taken.connect(hit_taken)
	health_system.died.connect(_die)

func hit_taken(damage_pos : Vector2, damage_stats : DamageStats):
	health_system.take_damage(damage_stats)

func _die():
	die.emit()
