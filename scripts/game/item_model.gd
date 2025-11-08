extends Node2D

class_name ItemModel;

@export var data: ItemData;
@export var timer: int;
var sprite: Sprite2D;

signal on_wave_completed();

func _ready() -> void:
	sprite = $Sprite;

func set_data(d: ItemData):
	data = d;
	timer = d.heat_timer;
	sprite.texture = d.raw_sprite;

func tick(temperature: UtilType.WaveTemperature):
	if data == null: return;
	if data.temperature != temperature: return;
	timer -= 1;
	if (timer <= 0):
		sprite.texture = data.cooked_sprite;
		on_wave_completed.emit();

func reset():
	if data == null: return;
	timer = data.heat_timer;
	sprite.texture = data.raw_sprite;
