class_name BasicMicrowaveUI extends IMicrowaveUI

@export var number_buttons: Array[Button]
@export var temperature_buttons: Array[Button]
@export var reset_button: Button
@export var timer_text: Label
var starting_input = "00:00"
var user_input = ""

func setup() -> void:
	print("basic microwave ui seting up..")
	start_button.pressed.connect(on_start_pressed)
	for i in range(len(number_buttons)):
		number_buttons[i].pressed.connect(on_number_pressed.bind(i))
	for i in range(len(temperature_buttons)):
		temperature_buttons[i].pressed.connect(on_temperature_pressed.bind(i+1))
	reset_button.pressed.connect(on_reset_pressed)
	command = MicrowaveMethod.new();
	user_input = ""

func _ready() -> void:
	super._ready()

func on_reset_pressed() -> void:
	user_input = ""
	timer_text.text = starting_input

func on_start_pressed_preprocess() -> void:
	time = user_input.to_int() #change time calculation here <--------------
	var min_unit := floori(time / 100.0)
	var sec_unit := time % 100
	var fixed_t := min_unit * 60 + sec_unit
	print("microwave ui -> ", fixed_t)
	command.duration = fixed_t
	# on_commit_command.emit(command) # IMicrowaveUI also send signal
	on_reset_pressed()

func on_temperature_pressed(index: int) -> void:
	command.temperature = index as UtilType.WaveTemperature

func on_number_pressed(index: int) -> void:
	if user_input.length() == 4:
		return
	user_input += "%d" % index
	var show_input = "0000"
	show_input = show_input.substr(0,4-user_input.length()) + user_input
	timer_text.text = show_input.substr(0,2) + ":" + show_input.substr(2,4)
