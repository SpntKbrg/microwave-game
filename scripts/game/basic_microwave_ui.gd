class_name BasicMicrowaveUI extends IMicrowaveUI

@export var number_buttons: Array[Button]
@export var reset_button: Button
@export var timer_text: Label
var starting_input = "000"
var user_input = ""

func setup() -> void:
	start_button.pressed.connect(on_start_pressed)
	user_input = ""

func _ready() -> void:
	super._ready()
	for i in range(len(number_buttons)):
		number_buttons[i].pressed.connect(on_number_pressed.bind(i))
	print("basic microwave ui seting up..")

func on_start_pressed_preprocess() -> void:
	time = user_input.to_int()
	print("microwave ui -> ", time)
	command = MicrowaveMethod.new();
	command.temperature = UtilType.WaveTemperature.HIGH
	command.duration = time

func on_number_pressed(index: int) -> void:
	user_input += "%d" % index
	timer_text.text = user_input
