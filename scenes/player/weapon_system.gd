extends Node2D

@onready var sprite_flipper = $"../SpriteFlipper"
@onready var attack_animation_player = $"../AttackAnimationPlayer"
@onready var hand_slot = $"../SpriteFlipper/HandSlot"
@onready var attack_timer = $AttackTimer

var equipped_weapon : WeapomBase

#FLAGS
var attack_input_pressed = false


# Limites de rotação em radianos
var min_angle = deg_to_rad(-45)
var max_angle = deg_to_rad(45)


func _ready():
	attack_animation_player.animation_finished.connect(attack_animation_fineshed)
	PlayerInventoryManager.weapon_equipped.connect(equip_weapon)

func _process(delta):
	if equipped_weapon is MeleeWeaponBase:
		melee_attack() #Lida com o attack corpo a corpo
		
	if equipped_weapon is RangedWeaponBase:
		ranged_attack()
		
		
func _unhandled_input(event):
	if event.is_action_pressed("mouse_left"):
		attack_input_pressed = true
		#get_viewport().set_input_as_handled()

func melee_attack():
	if attack_input_pressed and attack_timer.is_stopped():
		attack_animation_player.play("swing")
		equipped_weapon.play_sound()
		equipped_weapon.activate_hitbox()
		attack_input_pressed = false
		attack_timer.start()

func ranged_attack():
	var weapon_rotation = (get_global_mouse_position() - global_position).normalized().angle()
	var angle
	if sprite_flipper.scale.x == 1 :
		angle = clampf(weapon_rotation, min_angle, max_angle)
		equipped_weapon.rotation = angle
		equipped_weapon.scale = Vector2(1,1)
	else : 
		if weapon_rotation < 0:
			angle = clampf(weapon_rotation, deg_to_rad(-180), deg_to_rad(-135))
		else :
			angle = clampf(weapon_rotation, deg_to_rad(135), deg_to_rad(180))
		equipped_weapon.rotation = -angle
		equipped_weapon.scale = Vector2(-1,-1)
		
	if attack_input_pressed and attack_timer.is_stopped():
		equipped_weapon.play_sound()
		equipped_weapon.shoot(angle)
		attack_input_pressed = false
		attack_timer.start()

func attack_animation_fineshed(anim_name):
	if anim_name == "swing":
		attack_animation_player.play("RESET")
		equipped_weapon.deactivate_hitbox()
		
func equip_weapon(weapon : WeapomBase):
	if equipped_weapon == weapon:
		return
	equipped_weapon = weapon
	attack_timer.wait_time = weapon.attack_speed
	weapon.show()
	if weapon.type == weapon.WEAPOMS_TYPES.RANGED :
		weapon.position.y = -(weapon.weapom_sprite.texture.get_height()/2 - 12) 
	else :
		weapon.position.y = -(weapon.weapom_sprite.texture.get_height()/2 - 3) #Ajusta a altura da arma para o pivo ficar em baixo e nao no centro
	
	# "Removing" old weapon
	if len( hand_slot.get_children()) > 0:
		hand_slot.get_child(0).hide()
		hand_slot.remove_child(hand_slot.get_child(0))
	
	# Adding new
	hand_slot.add_child(weapon)


func _on_attack_timer_timeout():
	attack_timer.stop()
