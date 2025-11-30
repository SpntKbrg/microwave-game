extends Control

@export var microwave_set: Array[MicrowaveSpec]
@export var microwave_spawn_point: Node
@export var item_spawn_point: Node
@export var model_resource: ModelResource
@export var item_scene: PackedScene
@export var item_factory: ItemFactory
@export var customer_system: CustomerSystem
@export var microwave_ui: MicrowaveInspect

var orders: Dictionary[int, CustomerOrder] = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var microwave_factory = MicrowaveFactory.new();
	for microwave in microwave_set:
		var mw = microwave_factory.create(microwave);
		microwave_spawn_point.add_child.call_deferred(mw)
	microwave_ui.visible = false;
	customer_system.on_add_customer.connect(_on_add_customer)
	customer_system.on_remove_customer.connect(_on_remove_customer)
	customer_system.set_running(true)

func _on_add_customer(customer: Customer) -> void:
	# todo: add customer with order upper ui
	var generate_order = item_factory.generate_order()
	var customer_order = CustomerOrder.new(customer, generate_order)
	orders.set(customer.customer_id, customer_order)
	for order in generate_order:
		var item = item_scene.instantiate() as ItemButton
		item.set_data(order)
		item.pressed.connect(func():
			microwave_ui.visible = true	
			microwave_ui.setup(order)
		)
		item_spawn_point.add_child.call_deferred(item)

func _on_remove_customer(is_completed: bool, customer_id: int) -> void:
	# todo: remove customer ui
	pass

class CustomerOrder:
	var order_list: Array[ItemData]
	var customer: Customer
	var customer_panel: Node
	
	func _init(_customer: Customer, list: Array[ItemData]) -> void:
		customer = _customer
		order_list = list
	
	func set_customer_panel(panel: Node) -> void:
		customer_panel = panel
	
	func get_order_count() -> int:
		return order_list.size()
	
	func submit(item: ItemData) -> bool:
		var index = 0;
		for order in order_list:
			if order.type == item.type:
				order_list.remove_at(index)
				customer.on_item_complete()
				return true
			index += 1
		return false
