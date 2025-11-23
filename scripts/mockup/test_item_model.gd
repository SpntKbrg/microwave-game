extends Node2D

@onready var item: ItemModel = $ItemModel;
@onready var low_button: Button = $CanvasLayer/Control/HBoxContainer/low_tick;
@onready var medium_button: Button = $CanvasLayer/Control/HBoxContainer/medium_tick;
@onready var high_button: Button = $CanvasLayer/Control/HBoxContainer/high_tick;
@onready var reset_button: Button = $CanvasLayer/Control/HBoxContainer/Reset;

func _ready() -> void:
	var data = preload("res://resources/meatball.tres");
	item.set_data(data);
	var screen_size = get_viewport().size
	item.position = Vector2(screen_size.x / 2, screen_size.y / 2);
	var low_method = MicrowaveMethod.new();
	low_method.temperature = UtilType.WaveTemperature.LOW;
	low_button.pressed.connect(func (): item.tick(low_method));
	var medium_method = MicrowaveMethod.new();
	medium_method.temperature = UtilType.WaveTemperature.MEDIUM;
	medium_button.pressed.connect(func (): item.tick(medium_method));
	var high_method = MicrowaveMethod.new();
	high_method.temperature = UtilType.WaveTemperature.HIGH;
	high_button.pressed.connect(func (): item.tick(high_method));
	reset_button.pressed.connect(func (): item.reset());
