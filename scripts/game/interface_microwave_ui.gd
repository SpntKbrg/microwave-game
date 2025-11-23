@abstract class_name IMicrowaveUI extends Control

@export var start_button: Button

@abstract func additional_setup() -> void

signal on_commit_command(command: MicrowaveMethod, time: int)

func setup() -> void:
	start_button.pressed.connect(on_start_pressed)
	additional_setup()

func on_start_pressed(_command: MicrowaveMethod, time: int) -> void:
	on_commit_command.emit(_command, time)
	visible = false
