@abstract class_name IMicrowave extends Area2D

var microwave_ui: IMicrowaveUI
const basic_microwave_ui = preload("res://scenes/mockup/basic_microwave_ui.tscn")

func _ready() -> void:
	body_entered.connect(on_body_entered)
	setup()

func on_item_dropped(item: ItemModel) -> void:
	_show_ui()
	on_item_drop_addition(item)

func _show_ui() -> void:
	if microwave_ui == null:
		microwave_ui = basic_microwave_ui.instantiate()
		get_parent().add_child.call_deferred(microwave_ui)
	else:
		microwave_ui.visible = true

func on_body_entered(target: Node) -> void:
	print("something entering me..")
	if target is ItemModel:
		on_item_dropped(target)

@abstract
func setup()->void

@abstract
func on_item_drop_addition(item: ItemModel) -> void

@abstract
func on_commit_command(command: MicrowaveMethod,time: int) -> void
