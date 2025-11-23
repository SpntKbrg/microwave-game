@abstract class_name IMicrowave extends RigidBody2D

@export var microwave_ui: IMicrowaveUI

func on_item_dropped(item: ItemModel) -> void:
	_show_ui()
	on_item_drop_addition(item)

func _show_ui() -> void:
	microwave_ui.visible = true

func on_body_entered(target: Node) -> void:
	if target.is_class("ItemModel"):
		on_item_dropped(target)

@abstract
func setup()->void

@abstract
func on_item_drop_addition(item: ItemModel) -> void

@abstract
func on_commit_command(command: MicrowaveMethod) -> void
