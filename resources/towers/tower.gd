extends Resource
class_name Tower

#Class created to solve circular dependency between tower_scene and tower_info

@export var tower_info : TowerInfo
@export var tower_scene : PackedScene
