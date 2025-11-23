class_name MicrowaveFactory extends Node

const basic_microwave = preload("res://scenes/mockup/basic_microwave.tscn")

func _init() -> void:
	pass

func create(spec: MicrowaveSpec) -> Node2D:
	#check spec then gen microwave
	print("spec", spec.useTemperature)
	return basic_microwave.instantiate();
