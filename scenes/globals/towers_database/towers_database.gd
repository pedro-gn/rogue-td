extends Node


var cache : Dictionary = {}

@export_dir var towers_folder

func _ready():
	var folder = DirAccess.open(towers_folder)
	for tower_dir in folder.get_directories():
		var tower_dir_opened = DirAccess.open( towers_folder + '/' + tower_dir) # Diretorio de cada arma
		tower_dir_opened.list_dir_begin()
		var file_name = tower_dir_opened.get_next()
		while file_name != "":
			if file_name.contains("_tower.tres"):
				cache[file_name] = load(towers_folder + '/' + tower_dir + '/' + file_name)
			file_name = tower_dir_opened.get_next()

	
func get_weapon(id) -> PackedScene:
	return cache[id + '_tower.tres']
