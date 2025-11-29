class_name BasicMicrowave extends IMicrowave

var item: ItemModel

func _ready() -> void:
	super._ready()

func setup()->void:
	print("basic microwave seting up..")

func on_item_drop_addition(_item: ItemModel) -> void:
	item = _item

func on_commit_command(_command: MicrowaveMethod, _time: int) -> void:
	item.tick(_command)
