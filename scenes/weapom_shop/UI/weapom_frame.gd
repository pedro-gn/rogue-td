extends TextureRect
signal weapon_purchased(weapom)


@export var normal_texture : CompressedTexture2D
@export var mouse_hover_texture : CompressedTexture2D


@export var rich_text_label : RichTextLabel
@export var texture_rect : TextureRect

var weapom : WeapomBase


func _ready():
	PlayerInventoryManager.gold_changed.connect(change_cost_color)

#Change the cost text based on player gold
func change_cost_color(new_amount):
	if weapom.gold_cost > new_amount:
		rich_text_label.add_theme_color_override("default_color", Color(1,0,0,1))
	else:
		rich_text_label.add_theme_color_override("default_color", Color(1,1,1,1))


func set_weapom(_weapom):
	weapom = _weapom
	texture_rect.texture = weapom.weapom_sprite.texture
	rich_text_label.text = str(weapom.gold_cost)
	if weapom.gold_cost > PlayerInventoryManager.gold :
		rich_text_label.add_theme_color_override("default_color", Color(1,0,0,1))

func _on_mouse_entered():
	texture = mouse_hover_texture

func _on_mouse_exited():
	texture = normal_texture

#When player clicks to buy
func _on_gui_input(event : InputEvent):
	if event.is_action_pressed("mouse_left"):
		weapon_purchased.emit(weapom)
		PlayerInventoryManager.buy_weapom(weapom)
		queue_free()
