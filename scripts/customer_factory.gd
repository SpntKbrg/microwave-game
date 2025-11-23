class_name CustomerFactory

extends Node

var customer_scene = preload("res://scenes/customer.tscn")

var next_id = 0

func generate_customer() -> Customer:
	var new_customer_instance = customer_scene.instantiate()
	add_child(new_customer_instance)
	
	new_customer_instance.customer_id = next_id
	next_id += 1
	
	return new_customer_instance
