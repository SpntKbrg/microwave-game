class_name BasicMicrowave extends IMicrowave

var item: ItemModel

func setup()->void:
	print("basic microwave seting up..")
	
func _ready() -> void:
	super._ready()

func on_item_drop_addition(_item: ItemModel) -> void:
	if not microwave_ui.is_connected("on_commit_command", on_commit_command):
		print("connect on_commit_command")
		microwave_ui.on_commit_command.connect(on_commit_command)
	item = _item

func on_commit_command(_command: MicrowaveMethod, _time: int) -> void:
	print("do on_commit_command")
	item.tick(_command)
