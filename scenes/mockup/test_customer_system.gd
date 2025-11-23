extends Node

@export
var customer_system: CustomerSystem


func _on_add_customer_button_pressed() -> void:
	customer_system._generate_new_customer()


func _on_remove_first_customer_button_pressed() -> void:
	customer_system._remove_customer(0)
