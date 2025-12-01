extends Control

class_name MicrowaveInspect

@export var inspect_modal: InspectModal
@export var microwave_ui: BasicMicrowaveUI
@export var close_button: Button

var __condition_func: Callable
var __item_data: ItemData

signal on_commit_command(cmd: MicrowaveMethod)

func _ready() -> void:
	microwave_ui.on_commit_command.connect(__try_commit_command)
	close_button.pressed.connect(func(): self.visible = false)

func __try_commit_command(cmd: MicrowaveMethod) -> void:
	var precheck = __condition_func.call() as bool
	var item_check = __item_data.heat_timer == cmd.duration
	if not precheck or not item_check:
		SoundController.get_instance().play_sound(UtilType.SFX.CLICK_NEG)
		return
	on_commit_command.emit(cmd)
	SoundController.get_instance().play_sound(UtilType.SFX.CLICK_POS)
	visible = false

func get_microwave_ui() -> BasicMicrowaveUI:
	return microwave_ui

func setup(item: ItemData) -> void:
	__item_data = item
	inspect_modal.set_display_item(item)
	microwave_ui.current_item_type = item.type

func set_condition_func(callback: Callable) -> void:
	__condition_func = callback
