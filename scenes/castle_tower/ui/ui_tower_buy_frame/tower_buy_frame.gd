extends TextureRect
signal tower_bought(tower_res : Tower)

@export var normal_texture : Texture2D
@export var hover_texture : Texture2D

@export var texture_rect :TextureRect
@export var price_label : RichTextLabel


func _ready():
	PlayerInventoryManager.gold_changed.connect(update_gold_label)
	if PlayerInventoryManager.gold < tower_res.tower_info.gold_cost:
		price_label.modulate = Color.FIREBRICK
	else : 
		price_label.modulate = Color.FLORAL_WHITE
	
var tower_res : Tower : 
	set(new_value):
		tower_res = new_value
		texture_rect.texture = tower_res.tower_info.tower_thumb
		price_label.text = str(tower_res.tower_info.gold_cost)

func update_gold_label(new_amount):
	if new_amount < tower_res.tower_info.gold_cost:
		price_label.modulate = Color.FIREBRICK
	else : 
		price_label.modulate = Color.FLORAL_WHITE
	
func _on_mouse_entered():
	texture = hover_texture

func _on_mouse_exited():
	texture = normal_texture

func _on_gui_input(event):
	if event.is_action_pressed("mouse_left"):
		tower_bought.emit(tower_res)
