class_name CustomerSystem

extends Node

@export var customer_factory: CustomerFactory

@export_group("Customer Queue")
@export_custom(PROPERTY_HINT_RANGE, "1,10") var maximum_customer_queue: int = 1
@export_range(1, 60, 0.1, "seconds") var time_until_next_customer_lists: Array[float] = []
@export_range(1, 100, 1, "percentage") var time_variance: float = 20

var time_until_next_customer: float = 0
var customer_list: Array[Customer] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_process_time_until_next_customer(delta)
	
func on_customer_patient_time_out(id: int) -> void:
	print("Customer patient time out id: ", id)
	_remove_customer_by_id(id)

func on_customer_complete(id: int) -> void:
	print("Customer complete id: ", id)
	_remove_customer_by_id(id)

func _process_time_until_next_customer(delta: float) -> void:
	if(time_until_next_customer <= 0 && customer_list.size() < maximum_customer_queue):
		_generate_new_customer()
	
	time_until_next_customer -= delta

func _generate_new_customer() -> void:
	if customer_list.size() >= maximum_customer_queue:
		return
	
	var new_customer = customer_factory.generate_customer()
	customer_list.append(new_customer)
	new_customer.customer_patient_time_out_signal.connect(on_customer_patient_time_out)
	new_customer.customer_complete_signal.connect(on_customer_complete)
	time_until_next_customer = _get_new_time_until_next_customer()
	
	print("Adding a new customer")
	_print_current_customer()
	print("New waiting time until the next customer: ", time_until_next_customer)

func _get_new_time_until_next_customer() -> float:
	var index = clampi(customer_list.size(), 0, time_until_next_customer_lists.size() - 1)
	var time_modifier = (100 + randf() * time_variance) / 100
	
	return time_until_next_customer_lists[index] * time_modifier
	
func _remove_customer_by_id(id: int) -> void:
	print("Attempt removing the customer with id: ", id)
	for index in range(customer_list.size()):
		if customer_list[index].customer_id == id:
			_remove_customer_at_index(index)
			return
	print("Customer id not found: ", id)

func _remove_customer_at_index(index: int) -> void:
	if index < 0 and index >= customer_list.size():
		print("Customer index not found: ", index)
		return
	
	print("Remove the customer at index: ", index)
	
	var target_customer = customer_list[index]
	
	customer_list.remove_at(index)
	
	target_customer.queue_free()
	
	if time_until_next_customer <= 0:
		time_until_next_customer = _get_new_time_until_next_customer()
		print("New waiting time until the next customer: ", time_until_next_customer)
	
	_print_current_customer()
	
func _print_current_customer() -> void:
	print("Current customers: ", customer_list.map(func(element): return element.customer_id))
