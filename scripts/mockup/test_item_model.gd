extends Node2D

@onready var item: ItemModel = $ItemModel;
@onready var tick_button: Button = $CanvasLayer/Control/HBoxContainer/Tick;
@onready var reset_button: Button = $CanvasLayer/Control/HBoxContainer/Reset;

func _ready() -> void:
	var data = preload("res://resources/meatball.tres");
	item.set_data(data);
	var screen_size = get_viewport().size
	item.position = Vector2(screen_size.x / 2, screen_size.y / 2);
	item.on_wave_completed.connect(func (): print("wave completed"));
	# tick_button.pressed.connect(func (): item.tick(UtilType.WaveTemperature.HIGH)); # FIXME
	reset_button.pressed.connect(func (): item.reset());
