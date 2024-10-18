extends TextureRect
signal weapon_selected(weapom)


@export var normal_texture : CompressedTexture2D
@export var mouse_hover_texture : CompressedTexture2D


@export var texture_rect : TextureRect

var weapom : WeapomBase

func set_weapom(_weapom):
	weapom = _weapom
	texture_rect.texture = weapom.weapom_sprite.texture

func _on_mouse_entered():
	texture = mouse_hover_texture

func _on_mouse_exited():
	texture = normal_texture

#When player clicks to select
func _on_gui_input(event : InputEvent):
	if event.is_action_pressed("mouse_left"):
		PlayerInventoryManager.equipped_weapon = weapom
		print("Weapom Selected")
