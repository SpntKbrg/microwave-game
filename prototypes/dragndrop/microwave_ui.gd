extends Control
@export var number_buttons: Array[Button]
@export var reset_button: Button
@export var start_button: Button
@export var timer_text: Label

var starting_input = "000"
var user_input = ""

signal on_input()

func _ready() -> void:
	for i in range(len(number_buttons)):
		number_buttons[i].pressed.connect(on_number_pressed.bind(i))
	start_button.pressed.connect(on_start)


func on_start() -> void:
	user_input = ""
	visible = false
	on_input.emit()


func on_number_pressed(index: int) -> void:
	user_input += "%d" % index
	timer_text.text = user_input
	pass
