class_name GameSystem
extends Node


@export_category("Systems")
@export var customer_system: CustomerSystem
@export var item_factory: ItemFactory
@export var microwave_inspect: MicrowaveInspect
@export var input_state_handler: InputStateHandler
@export var item_shelf_spawner: ItemShelfSpawner
@export var microwave_spawner: MicrowaveSpawner

@export_category("Internal")
@export var __customer_data_holder: Node
@export var __customer_button_container: Control
@export var __microwave_container: Node

@export_category("Template")
@export var __customer_node_template: PackedScene # CustomerUiData
@export var __customer_button_template: PackedScene # CustomerButton

@export_category("Data")
@export var __item_resources: Array[ItemResource]

var __item_data: Dictionary[UtilType.ItemType, ItemResource]

func _ready() -> void:
	setup()
	__subscribe_events()
	start_game()


func __subscribe_events() -> void:
	customer_system.on_add_customer.connect(on_event_customer_add)
	input_state_handler.signal_show_microwave_ui.connect(func (is_showing: bool, item_type_id: int):
		microwave_inspect.visible = is_showing
		var item_resource := __item_data.get(item_type_id as UtilType.ItemType) as ItemResource
		var item = ItemData.new(
			item_type_id,
			randi_range(item_resource.timer_min_second, item_resource.timer_max_second),
			UtilType.WaveTemperature.LOW,
			item_resource.model,
			item_resource.model
		)
		microwave_inspect.setup(item)
	)
	item_shelf_spawner.on_item_selected.connect(input_state_handler.on_select_item)
	microwave_spawner.on_microwave_selected.connect(input_state_handler.on_select_microwave)
	microwave_inspect.on_commit_command.connect(input_state_handler.on_submit_microwave_cmd)
	input_state_handler.signal_try_command_microwave.connect(microwave_spawner.send_cmd)

func setup() -> void:
	__item_data = {}
	for item in __item_resources:
		__item_data.set(item.item_type, item)
	item_shelf_spawner.setup(__item_data)
	microwave_spawner.setup()
	microwave_inspect.set_condition_func(func ():
		return microwave_spawner.is_any_microwave_free()
	)

func start_game() -> void:
	customer_system.set_running(true)

func on_event_microwave_add(microwave: MicrowaveToggle) -> void:
	microwave.on_microwave_selected.connect(input_state_handler.on_select_microwave)

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
	customer_button.on_customer_selected.connect(input_state_handler.on_select_customer)
	__customer_button_container.add_child(customer_button)
	
func on_try_give_item_to_customer(microwave_id: int, customer_id: int) -> void:
	var selected_microwave_list := __get_microwave_list_by_id(microwave_id)
	var selected_customer_list := __get_customer_list_by_id(customer_id)
	
	if selected_microwave_list.size() == 0:
		print("GameSystem::on_try_give_item_to_customer : Can't find microwave with id: ", microwave_id)
		return
	
	if selected_customer_list.size() == 0:
		print("GameSystem::on_try_give_item_to_customer : Can't find customer with id: ", customer_id)
		return
	
	var selected_microwave : MicrowaveToggle = selected_microwave_list[0]
	var selected_customer :CustomerButton = selected_customer_list[0]
	
	if selected_microwave.is_running:
		print("GameSystem::on_try_give_item_to_customer : The microwave is still running.")
		return
		
	if not selected_microwave.completed_item_type or selected_microwave.completed_item_type == UtilType.ItemType.NULL:
		print("GameSystem::on_try_give_item_to_customer : The microwave doesn't have any item.")
		return
		
	var customer_item_icon_list := selected_customer.get_item_icon_list()
	
	for index in len(customer_item_icon_list):
		if customer_item_icon_list[index].item_type == selected_microwave.completed_item_type:
			print("GameSystem::on_try_give_item_to_customer : Found the requested item at index : ", index)
			selected_customer.remove_item_icon_at_index(index)
			return
			
	print("GameSystem::on_try_give_item_to_customer : Item not found")


func __get_microwave_list_by_id(microwave_id: int) -> Array:
	return (
		__microwave_container.get_children()
			.filter(func (child): return is_instance_of(child, MicrowaveToggle))
			.map(func (child): return child as MicrowaveToggle)
			.filter(func (child: MicrowaveToggle): return child.microwave_id == microwave_id)
	)
	
func __get_customer_list_by_id(customer_id: int) -> Array:
	return (
		__customer_button_container.get_children()
			.filter(func (child): return is_instance_of(child, CustomerButton))
			.map(func (child): return child as CustomerButton)
			.filter(func (child: CustomerButton): return child.get_customer_id() == customer_id)
	)
