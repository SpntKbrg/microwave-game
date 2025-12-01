class_name ItemShelfSpawner
extends Node


@export var __item_shelf: Node
@export var __item_shelf_btn_template: PackedScene

func _ready() -> void:
	for i in UtilType.ItemType.values():
		var icon_node = __item_shelf_btn_template.instantiate()
		var item_icon := icon_node as ItemShelfButton
		__item_shelf.add_child(item_icon)
		item_icon.setup(i)
