extends Node
class_name EnemyBaseScript

@export var hurtbox : HurtBox
@export var health_system : HealthSystem
@export var hit_system : HitSystem
@export var state_machine : StateMachine
@export var drop_system : DropSystem

func _ready():
	hurtbox.hit_taken.connect(hit_taken)
	health_system.died.connect(died)

	
func hit_taken(damage_stats : DamageStats, damage_pos : Vector2):
	hit_system.take_hit(damage_stats, damage_pos)
	state_machine.force_state_change("HitState")
	health_system.take_damage(damage_stats)

func died():
	drop_system.drop()
	state_machine.force_state_change("DieState")
