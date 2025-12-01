class_name CustomerFactory

extends Node

@export var customer_patient_time: float = 10
@export var customer_item_count: int = 3

var customer_scene = preload("res://scenes/customer.tscn")
var next_id: int = 0


func generate_customer() -> Customer:
	var new_customer_instance = customer_scene.instantiate()
	add_child(new_customer_instance)
	var rand_item_count = randi_range(1, customer_item_count)
	new_customer_instance.setup_customer(next_id, customer_patient_time, rand_item_count)
	next_id += 1
	
	return new_customer_instance
