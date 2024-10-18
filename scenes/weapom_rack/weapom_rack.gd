extends Node

@onready var weapom_grid_container = $CanvasLayer/CenterContainer/WeaponsShopList/MarginContainer/WeapomGridContainer
@onready var weapom_frame_scene = preload("res://scenes/weapom_rack/UI/weapom_select_frame.tscn")
@export var weapons_shop_list : CenterContainer

func _ready():
	PlayerInventoryManager.weapon_bought.connect(update_weapons_list)


func update_weapons_list(weapon):
	var weapom_frame = weapom_frame_scene.instantiate()
	weapom_frame.set_weapom(weapon)
	weapom_frame.weapon_selected.connect(_on_weapom_select_clicked)
	weapom_grid_container.add_child(weapom_frame)


#activated when a weapom item is clicked
#all functions are made in weapom frame at the moment
func _on_weapom_select_clicked(weapom : WeapomBase):
	pass

#Handle open and close the menu
func _on_interact_area_interacted():
	weapons_shop_list.show() if weapons_shop_list.visible == false else weapons_shop_list.hide()
	
func _on_interact_area_body_exited(body):
	weapons_shop_list.hide()
