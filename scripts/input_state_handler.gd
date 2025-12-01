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
signal signal_show_microwave_ui(is_showing: bool)
# signal signal_try_command_microwave(item_id: int, command)

func _ready() -> void:
	reset_state()

func on_select_microwave(id: int) -> void:
	__state = SelectionState.MICROWAVE_SELECTED
	__selected_id = id

func on_select_customer(id: int) -> void:
	if __state != SelectionState.MICROWAVE_SELECTED:
		return
	signal_try_give_item_to_customer.emit(__selected_id, id)
	reset_state()

func on_select_item(id: int) -> void:
	__state = SelectionState.ITEM_SELECTED
	__selected_id = id
	signal_show_microwave_ui.emit(true)


func on_submit_microwave_cmd() -> void:
	if __state != SelectionState.ITEM_SELECTED:
		return
	# signal_try_command_microwave.emit(...)


func reset_state() -> void:
	__selected_id = -1
	__state = SelectionState.NOTHING
