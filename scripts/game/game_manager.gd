extends Node

@export var microwave_set: Array[MicrowaveSpec]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var microwave_factory = MicrowaveFactory.new();
	for microwave in microwave_set:
		microwave_factory.create(microwave);
