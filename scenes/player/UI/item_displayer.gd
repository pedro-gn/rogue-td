extends NinePatchRect

@onready var coin_label = $MarginContainer/CenterContainer/HBoxContainer/CoinLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	coin_label.text = str(0)
	PlayerInventoryManager.connect("gold_changed", update_gold_amount)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_gold_amount(new_amount):
	coin_label.text = str(new_amount)
