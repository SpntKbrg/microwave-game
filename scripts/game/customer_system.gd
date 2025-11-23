class_name CustomerSystem

extends Node

@export_group("Customer Queue")
@export_custom(PROPERTY_HINT_RANGE, "1,10") var maximum_customer_queue: int = 1
@export_range(1, 60, 0.1, "seconds") var time_until_next_customer_lists: Array[float] = []
@export_range(1, 100, 1, "percentage") var time_variance: float = 10

var time_until_next_customer: float = 0
var customer_list: Array[int] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(time_until_next_customer <= 0 && customer_list.size() < maximum_customer_queue):
		generate_new_customer()
	
	time_until_next_customer -= delta
	

func generate_new_customer() -> void:
	if customer_list.size() >= maximum_customer_queue:
		return
		
	customer_list.append(randi())
	time_until_next_customer = get_new_time_until_next_customer()
	
	print("Adding a new customer")
	print("Current customers: ", customer_list)
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
	
	customer_list.remove_at(index)
	
	if time_until_next_customer <= 0:
		time_until_next_customer = get_new_time_until_next_customer()
		print("New waiting time until the next customer: ", time_until_next_customer)
	
	print("Remaining customers: ", customer_list)
	
	
