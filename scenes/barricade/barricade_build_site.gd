extends Node2D

@onready var interact_area = $InteractArea
@onready var h_box_container = $HBoxContainer
@onready var price_label = $HBoxContainer/RichTextLabel

@onready var animation_player = $AnimationPlayer
var castle_tower = load("res://scenes/castle_tower/castle_tower.tscn")

var tower_build_price = 35

func _physics_process(delta):
	if PlayerInventoryManager.gold >= tower_build_price:
		price_label.self_modulate = Color.LIME_GREEN
	else:
		price_label.self_modulate = Color.DARK_RED



func _on_interact_area_interacted():
	if PlayerInventoryManager.gold >= tower_build_price:
		animation_player.play("spawn")
		PlayerInventoryManager.subtract_gold(tower_build_price)

func _on_interact_area_body_entered(body):
	h_box_container.show()


func _on_interact_area_body_exited(body):
	h_box_container.hide()

	pass
