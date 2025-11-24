extends IMicrowaveUI

@export var number_buttons: Array[Button]
@export var reset_button: Button
@export var timer_text: Label
var starting_input = "000"
var user_input = ""

func _ready() -> void:
	for i in range(len(number_buttons)):
		number_buttons[i].pressed.connect(on_number_pressed.bind(i))
	print("basic microwave ui seting up..")

func on_start_pressed_preprocess() -> void:
	time = user_input.to_int()
	command = MicrowaveMethod.new();
	command.temperature = UtilType.WaveTemperature.HIGH

func on_number_pressed(index: int) -> void:
	user_input += "%d" % index
	timer_text.text = user_input

func additional_setup() -> void:
	user_input = ""
	visible = false
