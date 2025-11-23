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
	process_time_until_next_customer(delta)
	process_current_customer()
	

func process_time_until_next_customer(delta: float) -> void:
	if(time_until_next_customer <= 0 && customer_list.size() < maximum_customer_queue):
		generate_new_customer()
	
	time_until_next_customer -= delta
	
func process_current_customer() -> void:
	var index_to_delete_list: Array[int] = []
	for index in range(customer_list.size()):
		var customer = customer_list[index]
		if customer.patient_time <= 0:
			index_to_delete_list.push_front(index)
	
	for index_to_delete in index_to_delete_list:
		remove_customer(index_to_delete)

func generate_new_customer() -> void:
	if customer_list.size() >= maximum_customer_queue:
		return
		
	customer_list.append(customer_factory.generate_customer())
	time_until_next_customer = get_new_time_until_next_customer()
	
	print("Adding a new customer")
	print_current_customer()
	print("New waiting time until the next customer: ", time_until_next_customer)

func get_new_time_until_next_customer() -> float:
	var index = clampi(customer_list.size(), 0, time_until_next_customer_lists.size() - 1)
	var time_modifier = (100 + randf() * time_variance) / 100
	
	return time_until_next_customer_lists[index] * time_modifier
	
func remove_customer(index: int) -> void:
	if index < 0 and index >= customer_list.size():
		print("Customer index not found: ", index)
		return
	
	print("Remove the customer at index: ", index)
	
	var target_customer = customer_list[index]
	
	customer_list.remove_at(index)
	
	target_customer.queue_free()
	
	if time_until_next_customer <= 0:
		time_until_next_customer = get_new_time_until_next_customer()
		print("New waiting time until the next customer: ", time_until_next_customer)
	
	print_current_customer()
	
func print_current_customer() -> void:
	print("Current customers: ", customer_list.map(func(element): return element.customer_id))
