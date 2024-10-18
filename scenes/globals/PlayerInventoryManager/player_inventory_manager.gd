extends Node
signal item_changed(item : AbstractItem, qnt : int)
signal gold_changed(new_amount)
signal weapon_bought(weapon)
signal weapon_equipped(weapon)

@onready var gold_sfx = $AudioStreamPlayer

@export var gold : int :
	set(new_amount):
		gold = new_amount
		gold_sfx.pitch_scale = randf_range(0.85, 1.15)
		gold_changed.emit(gold)
		gold_sfx.play()

var equipped_weapon : WeapomBase : 
	set(new_weapon):
		equipped_weapon = new_weapon
		weapon_equipped.emit(equipped_weapon)


#Array containing weapons the player buys
var weapons_owned = []

func _ready():
	gold = 200

#Add a gold amount to total gold
func add_gold(amount : int):
	gold = clampi(gold+amount, 0, 999)
	
#Subtract a gold amount to total gold
func subtract_gold(amount : int):
	gold = clampi(gold-amount, 0, 999)

#function called when a item is collected
func on_item_collected(item : AbstractItem):
	if item.item.item_name == "gold":
		gold = clampi(gold+1, 0, 999)
		gold_changed.emit(gold)

#Add a weapom to owened and discount the cost 
func buy_weapom(weapon : WeapomBase):
	if weapon in weapons_owned:
		print("Weapom Already Owned")
		return false
	else:
		if weapon.gold_cost <= gold:
			weapons_owned.append(weapon)
			subtract_gold(weapon.gold_cost)
			weapon_bought.emit(weapon)
			print("Weapom Buyed")
			return true
		else:
			print("Not Enough Gold")
			return false
