extends CharacterBody2D

@onready var coin_audio_player = $CoinAudioPlayer
@onready var hurt_box = $HurtBox
@onready var health_system = $HealthSystem
@onready var state_machine = $StateMachine
@onready var hit_system = $HitSystem

func _physics_process(delta):
	global_position = global_position.round()

func _ready():
	#Connect to the signals
	hurt_box.hit_taken.connect(self.hit_taken)
	health_system.died.connect(self.die)
	
#Function activated when player takes hit
func hit_taken(damage_stats : DamageStats, damage_pos : Vector2):
	health_system.take_damage(damage_stats)
	state_machine.force_state_change("Hit")
	hit_system.take_hit(damage_stats, damage_pos)


#Function activated when player dies
func die():
	print("Morreu")

#Function activated when player collects a item
func _on_collect_area_collected(item):
	if item.item.item_name == "gold" :
		coin_audio_player.play()
		PlayerInventoryManager.add_gold(1)
