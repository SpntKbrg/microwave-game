class_name Customer

extends Node

var customer_id: int = -1
var max_patient_time: float = 10
var current_patient_time: float = max_patient_time
var remain_item_count: int = 1

signal customer_id_update_signal(id: int)
signal customer_remain_item_count_update_signal(item_count: int)
signal customer_patient_time_out_signal(id: int)
signal customer_complete_signal(id: int)

func setup_customer(id: int, patient_time: float, item_count: int):
	customer_id = id
	
	if patient_time > 0:
		max_patient_time = patient_time
		current_patient_time = max_patient_time
	
	if item_count > 0:
		remain_item_count = item_count
	
	customer_id_update_signal.emit(customer_id)
	customer_remain_item_count_update_signal.emit(remain_item_count)
	#print("Setup customer with id: ", customer_id, " patient time: ", max_patient_time)

func get_current_patient_time_ratio() -> float:
	return current_patient_time / max_patient_time

func on_item_complete() -> void:
	remain_item_count -= 1
	customer_remain_item_count_update_signal.emit(remain_item_count)
	
	if remain_item_count <= 0:
		customer_complete_signal.emit(customer_id)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	current_patient_time = current_patient_time - delta
	
	if current_patient_time <= 0:
		customer_patient_time_out_signal.emit(customer_id)
