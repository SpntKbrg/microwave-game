class_name InputStateHandler
extends Node

enum SelectionState {
	NOTHING = 0,
	ITEM_SELECTED,
	MICROWAVE_SELECTED,
}

var __selected_id: int
var __state: SelectionState


signal signal_try_give_item_to_customer(microwave_id: int, customer_id: int)
signal signal_show_microwave_ui(is_showing: bool, item_type_id: int)
signal signal_try_command_microwave(command: MicrowaveMethod)
signal signal_try_clearing_microwave(microwave_id: int)

func _ready() -> void:
	reset_state()

func on_select_microwave(id: int) -> void:
	print("try selecting microwave id:", id)
	SoundController.get_instance().play_sound(UtilType.SFX.CLICK_POS)
	__state = SelectionState.MICROWAVE_SELECTED
	__selected_id = id

func on_select_customer(id: int) -> void:
	print("try selecting customer id: ", id)
	if __state != SelectionState.MICROWAVE_SELECTED:
		return
	print("try give item from microwave id: ", __selected_id, " to customer id: ", id)
	signal_try_give_item_to_customer.emit(__selected_id, id)
	reset_state()
	
func on_select_trash_bin() -> void:
	print("try selecting trash bin")
	if __state != SelectionState.MICROWAVE_SELECTED:
		return
	print("try clearing item from microwave id: ", __selected_id)
	signal_try_clearing_microwave.emit(__selected_id)

func on_select_item(id: int) -> void:
	print("try selecting item id: ", id)
	__state = SelectionState.ITEM_SELECTED
	__selected_id = id
	signal_show_microwave_ui.emit(true, __selected_id)

func on_submit_microwave_cmd(cmd: MicrowaveMethod) -> void:
	if __state != SelectionState.ITEM_SELECTED:
		return
	signal_try_command_microwave.emit(cmd)
	reset_state()


func reset_state() -> void:
	__selected_id = -1
	__state = SelectionState.NOTHING
