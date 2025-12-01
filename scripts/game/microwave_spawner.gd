class_name MicrowaveSpawner
extends Node


@export var microwave_set: Array[MicrowaveSpec]
@export var microwave_spawn_point: Node

func _ready() -> void:
	var microwave_factory = MicrowaveFactory.new();
	for microwave in microwave_set:
		var mw = microwave_factory.create(microwave);
		microwave_spawn_point.add_child.call_deferred(mw)

func is_any_microwave_free() -> bool:
	for microwave in microwave_spawn_point.get_children():
		if not (microwave as MicrowaveToggle).is_running:
			return true
	return false


func send_cmd(command: MicrowaveMethod) -> void:
	for microwave in microwave_spawn_point.get_children():
		var microwave_chked := (microwave as MicrowaveToggle)
		if not microwave_chked.is_running:
			print("microwave found")
			microwave_chked.commit_command(command)
			return
	print("err: no microwave found")
