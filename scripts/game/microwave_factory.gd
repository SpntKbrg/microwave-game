class_name MicrowaveFactory extends Node

func _init() -> void:
	pass

func create(spec: MicrowaveSpec) -> BasicMicrowave:
	#check spec then gen microwave
	return BasicMicrowave.new()
