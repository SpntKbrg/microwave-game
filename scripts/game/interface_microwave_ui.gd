@abstract class_name IMicrowaveUI extends Control

@export var start_button: Button

@abstract func additional_setup() -> void

var command: MicrowaveMethod
var time: int

signal on_commit_command(command: MicrowaveMethod, time: int)

func setup() -> void:
	start_button.pressed.connect(on_start_pressed.bind(command, time))
	additional_setup()

func on_start_pressed(_command: MicrowaveMethod, _time: int) -> void:
	on_start_pressed_preprocess()
	on_commit_command.emit(_command, _time)
	visible = false

@abstract func on_start_pressed_preprocess() -> void
