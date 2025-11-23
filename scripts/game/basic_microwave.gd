class_name BasicMicrowave extends IMicrowave

var item: ItemModel

func setup()->void:
	pass

func on_item_drop_addition(_item: ItemModel) -> void:
	item = _item

func on_commit_command(_command: MicrowaveMethod) -> void:
	item.tick(_command)
