class_name ItemShelfSpawner
extends Node


@export var __item_shelf: Node
@export var __item_shelf_btn_template: PackedScene

signal on_item_selected(item_type: int)

func setup(item_list: Dictionary[UtilType.ItemType, ItemResource]) -> void:
	for item in item_list.values() as Array[ItemResource]:
		var icon_node = __item_shelf_btn_template.instantiate()
		var item_button := icon_node as ItemShelfButton
		__item_shelf.add_child(item_button)
		item_button.setup(item)
		item_button.pressed.connect(func () -> void:
			on_item_selected.emit(item.item_type)
		)
