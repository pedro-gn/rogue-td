extends StaticBody2D
@onready var hurt_box = $HurtBox
@onready var health_system = $HealthSystem

# Called when the node enters the scene tree for the first time.
func _ready():
	hurt_box.hit_taken.connect(hit_taken)

	
func hit_taken(damage_stats : DamageStats, damage_pos : Vector2):
	health_system.take_damage(damage_stats)
