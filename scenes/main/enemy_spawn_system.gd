extends Node2D

var spawn_points = []

@export var disable : bool = false

# Configurações iniciais
@export var spawn_begin_hour : int 
@export var enemies : Array[PackedScene]


var spawn_start_hour = 19  
var spawn_end_hour = 5     



var last_minutes
var last_hour
var enemies_per_hour
var total_enemies_spawned_per_hour

func _ready():
	for spawn_point in self.get_children():
		spawn_points.append(spawn_point)
		
func spawn_enemies(day, hour, minutes):
	if disable:
		return
	
	if (hour in range(spawn_start_hour, 24, 1) or hour in range(0, spawn_end_hour , 1)) and minutes == 0:
		enemies_per_hour = day+2
		total_enemies_spawned_per_hour = 0
	
	if total_enemies_spawned_per_hour == enemies_per_hour :
		return
		
	var enemy_instance : CharacterBody2D = enemies.pick_random().instantiate()
	enemy_instance.global_position = spawn_points.pick_random().global_position
	get_tree().root.add_child(enemy_instance)
	total_enemies_spawned_per_hour += 1
