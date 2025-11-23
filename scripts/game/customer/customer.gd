class_name Customer

extends Node

var customer_id: int = -1
var max_patient_time: float = 10
var current_patient_time: float = max_patient_time

signal customer_patient_time_out(id: int)

func setup_customer(id: int, patient_time: float):
	customer_id = id
	if patient_time > 0:
		max_patient_time = patient_time
		current_patient_time = max_patient_time
		
	#print("Setup customer with id: ", customer_id, " patient time: ", max_patient_time)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	current_patient_time = current_patient_time - delta
	
	if current_patient_time <= 0:
		customer_patient_time_out.emit(customer_id)
