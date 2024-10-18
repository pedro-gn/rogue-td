extends Node

@onready var weapom_grid_container = $CanvasLayer/WeaponsShopList/MarginContainer/WeapomGridContainer
@onready var weapom_frame_scene = preload("res://scenes/weapom_shop/UI/weapom_frame.tscn")
@export var weapons_shop_list : PanelContainer

func _ready():
	for weapom in WeapomsDatabase.cache:
		var weapom_frame = weapom_frame_scene.instantiate()
		var weapom_instance = WeapomsDatabase.cache[weapom].instantiate()
		weapom_frame.set_weapom(weapom_instance)
		weapom_frame.weapon_purchased.connect(_on_weapom_buy_clicked)
		weapom_grid_container.add_child(weapom_frame)

#activated when a weapom item is clicked
#all functions are made in weapom frame at the moment
func _on_weapom_buy_clicked(weapom : WeapomBase):
	pass

#Handle open and close the menu
func _on_interact_area_interacted():
	weapons_shop_list.show() if weapons_shop_list.visible == false else weapons_shop_list.hide()
func _on_interact_area_body_exited(body):
	weapons_shop_list.hide()
