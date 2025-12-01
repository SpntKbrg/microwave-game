class_name GameSystem
extends Node


@export_category("Systems")
@export var customer_system: CustomerSystem
@export var item_factory: ItemFactory
@export var microwave_inspect: MicrowaveInspect
@export var input_state_handler: InputStateHandler

@export_category("Internal")
@export var __customer_data_holder: Node
@export var __customer_button_container: Control

@export_category("Template")
@export var __customer_node_template: PackedScene # CustomerUiData
@export var __customer_button_template: PackedScene # CustomerButton

var __inspect_modal: InspectModal

func _ready() -> void:
	__setup()
	__subscribe_events()
	start_game()


func __setup() -> void:
	__inspect_modal = microwave_inspect.get_microwave_ui()


func __subscribe_events() -> void:
	customer_system.on_add_customer.connect(on_event_customer_add)
	input_state_handler.signal_show_microwave_ui.connect(
		func (is_showing: bool): __inspect_modal.visible = is_showing
	)

func start_game() -> void:
	customer_system.set_running(true)


func on_event_customer_add(customer: Customer) -> void:
	var customer_id := customer.customer_id
	var cart := item_factory.generate_order(customer.remain_item_count)
	var customer_node := __customer_node_template.instantiate()
	var customer_data := (customer_node as CustomerUiData)
	__customer_data_holder.add_child(customer_node)
	customer_data.name = str(customer_id)
	customer_data.customer = customer
	customer_data.cart = cart
	var customer_button_node := __customer_button_template.instantiate()
	var customer_button := (customer_button_node as CustomerButton)
	customer_button.setup(customer_data)
	customer_button.name = str(customer_id)
	__customer_button_container.add_child(customer_button)
