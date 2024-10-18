extends Node
class_name DropSystem

@export var gold_amount : int

var abstract_item = preload("res://scenes/common/abstract_item/abstract_item.tscn")
var gold_res = preload("res://items/gold/gold.tres")

func drop():
	var abstract_instance : AbstractItem = abstract_item.instantiate()
	abstract_instance.global_position = owner.global_position
	abstract_instance.item = gold_res
	get_tree().root.get_node("Main").call_deferred("add_child", abstract_instance)
