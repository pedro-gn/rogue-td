extends Node

@export var empty_sell_button : CompressedTexture2D
@export var empty_sell_button_hover : CompressedTexture2D

@export var red_sell_button : CompressedTexture2D
@export var red_sell_button_hover : CompressedTexture2D


@onready var tower_menu = $CanvasLayer/TowerMenu
@onready var grid_container = $CanvasLayer/TowerMenu/HBoxContainer/PanelContainer/ScrollContainer/GridContainer

@onready var slot1_texture_rect = %Slot1TowerTexture
@onready var sell_button1 = %Slot1SellButton
@onready var sell_button1_label = %Slot1ButtonTextLabel
@onready var sell_button1_gold_icon = %Slot1SellButtonIcon

@onready var slot2_texture_rect = %Slot2TowerTexture
@onready var sell_button2 = %SellButton2
@onready var sell_button2_label = %Slot2ButtonTextLabel
@onready var sell_button2_gold_icon = %Slot2SellButtonIcon

@onready var tower1_slot = $Slot1Marker
@onready var tower2_slot = $Slot2Marker

var tower_buy_frame_scene = preload("res://scenes/castle_tower/ui/ui_tower_buy_frame/tower_buy_frame.tscn")

var tower1_instance : TowerBase
var tower1_res : Tower :
	set(new_value):
		tower1_res = new_value
		if tower1_res != null :
			slot1_texture_rect.texture = tower1_res.tower_info.tower_thumb
			sell_button1.texture_normal = red_sell_button
			sell_button1.texture_hover = red_sell_button_hover
			sell_button1_label.text = "SELL  " + str(tower1_res.tower_info.gold_cost/2)
			sell_button1_gold_icon.show()
			slot1_texture_rect.show()
		else:
			slot1_texture_rect.hide()
			sell_button1.texture_normal = empty_sell_button
			sell_button1.texture_hover  = empty_sell_button_hover
			sell_button1_label.text = ""
			sell_button1_gold_icon.hide()
			
var tower2_instance : TowerBase
var tower2_res : Tower :
	set(new_value):
		tower2_res = new_value
		if tower2_res != null :
			slot2_texture_rect.texture = tower2_res.tower_info.tower_thumb
			sell_button2.texture_normal = red_sell_button
			sell_button2.texture_hover = red_sell_button_hover
			sell_button2_label.text = "SELL  " + str(tower2_res.tower_info.gold_cost/2)
			sell_button2_gold_icon.show()
			slot2_texture_rect.show()
		else:
			slot2_texture_rect.hide()
			sell_button2.texture_normal = empty_sell_button
			sell_button2.texture_hover  = empty_sell_button_hover
			sell_button2_label.text = ""
			sell_button2_gold_icon.hide()

func _ready():
	tower1_res = null
	tower1_instance = null
	
	tower2_res = null
	tower2_instance = null
	
	for tower in TowersDatabase.cache.values():
		var tower_frame = tower_buy_frame_scene.instantiate()
		tower_frame.tower_bought.connect(buy_tower)
		tower_frame.tower_res =  tower
		grid_container.add_child(tower_frame)


func buy_tower(tower_res : Tower):
	if tower1_instance == null and PlayerInventoryManager.gold >= tower_res.tower_info.gold_cost :
		tower1_instance = tower_res.tower_scene.instantiate()
		tower1_res = tower_res
		tower1_slot.add_child(tower1_instance)
		PlayerInventoryManager.subtract_gold(tower1_res.tower_info.gold_cost)
	
	elif tower2_instance == null and PlayerInventoryManager.gold >= tower_res.tower_info.gold_cost:
		tower2_instance = tower_res.tower_scene.instantiate()
		tower2_res = tower_res
		tower2_slot.add_child(tower2_instance)
		PlayerInventoryManager.subtract_gold(tower2_res.tower_info.gold_cost)


func _on_interact_area_interacted():
	if tower_menu.visible == false :
		tower_menu.show()
	else :
		tower_menu.hide()

func _on_interact_area_body_exited(body):
	tower_menu.hide()


func _on_sell_button_1_pressed():
	if tower1_res != null :
		PlayerInventoryManager.add_gold(tower1_res.tower_info.gold_cost/2)
		tower1_res = null
		tower1_instance.call_deferred("queue_free")


func _on_sell_button_2_pressed():
	if tower2_res != null :
		PlayerInventoryManager.add_gold(tower2_res.tower_info.gold_cost/2)
		tower2_res = null
		tower2_instance.call_deferred("queue_free")
