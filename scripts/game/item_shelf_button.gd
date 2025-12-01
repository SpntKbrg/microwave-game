class_name ItemShelfButton
extends Button


@export var __item_icon: ItemIcon
@export var __item_time_hint: Label


func setup(item_type: UtilType.ItemType) -> void:
	__item_icon.setup(item_type)
