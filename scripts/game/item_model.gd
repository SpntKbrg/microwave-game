extends Node2D

class_name ItemModel;

@export var data: ItemData;
@export var timer: int;
var sprite: Sprite2D;

func _ready() -> void:
	sprite = $Sprite;

func set_data(d: ItemData):
	data = d;
	timer = d.heat_timer;
	sprite.texture = d.raw_sprite;

func tick(method: MicrowaveMethod):
	if data == null: return;
	if data.temperature != method.temperature: return;
	timer -= 1;
	if (timer <= 0):
		sprite.texture = data.cooked_sprite;
		# TODO use model instead

func reset():
	if data == null: return;
	timer = data.heat_timer;
	sprite.texture = data.raw_sprite;
	# TODO use model instead
