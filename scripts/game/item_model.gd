extends Node2D

class_name ItemModel;

@export var data: ItemData;
@export var progress: int;
var sprite: Sprite2D;

func _ready() -> void:
	sprite = $Sprite;

func set_data(d: ItemData):
	data = d;
	progress = d.heat_timer * d.temperature;
	print("item hp: ", progress)
	sprite.texture = d.raw_sprite;

func tick(method: MicrowaveMethod):
	if data == null: return;
	var progress_elapse: int = method.temperature;
	if method.duration != 0:
		progress_elapse = method.temperature * method.duration;
	progress -= progress_elapse;
	if (progress <= 0):
		sprite.texture = data.cooked_sprite;
		# TODO use model instead

func reset():
	if data == null: return;
	progress = data.heat_timer;
	sprite.texture = data.raw_sprite;
	# TODO use model instead
