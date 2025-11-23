extends Node

@export
var customer_system: CustomerSystem


func _on_add_customer_button_pressed() -> void:
	customer_system.generate_new_customer()


func _on_remove_first_customer_button_pressed() -> void:
	customer_system.remove_customer(0)
