extends Node

var cache : Dictionary = {}

@export_dir var weapons_folder

func _ready():
	var folder = DirAccess.open(weapons_folder)
	for dir in folder.get_directories():
		var weapon_type_dir_opened = DirAccess.open( weapons_folder + '/' + dir ) # Sub diretorios das categorias como melee, ranged, etc...
		
		for weapon_dir in weapon_type_dir_opened.get_directories():
			var weapon_dir_opened = DirAccess.open( weapons_folder + '/' + dir + '/' + weapon_dir) # Diretorio de cada arma
			weapon_dir_opened.list_dir_begin()
			var file_name = weapon_dir_opened.get_next()
			while file_name != "":
				if file_name.contains(".tscn"):
					cache[file_name] = load(weapons_folder + '/' + dir + '/' + weapon_dir + '/' + file_name)
				file_name = weapon_dir_opened.get_next()
				
func get_weapon(id) -> PackedScene:
	return cache[id + '.tscn']
