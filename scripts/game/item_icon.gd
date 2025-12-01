class_name ItemIcon
extends TextureRect

@export_category("Data")
@export var item_icon_dict: Dictionary[UtilType.ItemType, Texture2D]

var item_type: UtilType.ItemType


func setup(type: UtilType.ItemType) -> void:
	item_type = type
	texture = item_icon_dict.get(type)
