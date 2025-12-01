class_name MicrowaveSpawner
extends Node


@export var microwave_set: Array[MicrowaveSpec]
@export var microwave_spawn_point: Node

signal on_microwave_selected(microwave_id: int)

var currId = 1

func setup() -> void:
	var microwave_factory = MicrowaveFactory.new();
	for microwave in microwave_set:
		var mw := microwave_factory.create(microwave) as MicrowaveToggle;
		microwave_spawn_point.add_child(mw)
		mw.on_microwave_selected.connect(on_selected)
		mw.microwave_id = currId
		currId += 1

func on_selected(microwave_id: int) -> void:
	on_microwave_selected.emit(microwave_id)
