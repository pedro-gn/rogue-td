extends Node2D
class_name WeapomBase

enum WEAPOMS_TYPES {MELEE, RANGED}
@export var weapom_name : String
@export var weapom_sprite : Sprite2D
@export var type : WEAPOMS_TYPES
@export var weapon_sound_stream : AudioStreamPlayer2D
@export var attack_speed : float
@export var gold_cost : int


func play_sound():
	weapon_sound_stream.pitch_scale = randf_range(0.9 , 1.1)
	weapon_sound_stream.play()
