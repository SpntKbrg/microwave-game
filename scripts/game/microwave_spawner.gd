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

func is_any_microwave_free() -> bool:
	for microwave in microwave_spawn_point.get_children():
		var microwave_chked := (microwave as MicrowaveToggle)
		if not microwave_chked.is_running and microwave_chked.current_command == null:
			return true
	return false


func send_cmd(command: MicrowaveMethod) -> void:
	for microwave in microwave_spawn_point.get_children():
		var microwave_chked := (microwave as MicrowaveToggle)
		if not microwave_chked.is_running and microwave_chked.current_command == null:
			print("microwave found")
			microwave_chked.commit_command(command)
			return
	print("err: no microwave found")
