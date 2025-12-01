class_name MicrowaveSpawner
extends Node


@export var microwave_set: Array[MicrowaveSpec]
@export var microwave_spawn_point: Node

func _ready() -> void:
	var microwave_factory = MicrowaveFactory.new();
	for microwave in microwave_set:
		var mw = microwave_factory.create(microwave);
		microwave_spawn_point.add_child.call_deferred(mw)
