extends Node2D

@onready var spawn_system = $SpawnSystem
@export var player : Node2D
@export var camera : Node2D
@onready var day_night_system = $DayNightSystem

var last_hour =  0

func _ready():
	day_night_system.time_tick.connect(spawn_system.spawn_enemies)
