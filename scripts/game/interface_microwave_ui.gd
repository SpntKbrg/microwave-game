@abstract class_name IMicrowaveUI extends Control

@export var start_button: Button

var command: MicrowaveMethod
var time: int

signal on_commit_command(command: MicrowaveMethod, time: int)

func _ready() -> void:
	setup()

func on_start_pressed() -> void:
	on_start_pressed_preprocess()
	on_commit_command.emit(command, time)
	visible = false

@abstract func on_start_pressed_preprocess() -> void

@abstract func setup() -> void
