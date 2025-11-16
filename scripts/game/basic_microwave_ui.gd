extends IMicrowaveUI

@export var microwave: IMicrowave
@export var number_buttons: Array[Button]
@export var reset_button: Button
@export var timer_text: Label

var command: MicrowaveMethod

func _ready() -> void:
	command = MicrowaveMethod.new()
	setup()

func additional_setup() -> void:
	pass
