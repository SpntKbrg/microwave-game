extends Button

class_name ItemButton

@export var progress: int;
@export var model_holder: ModelHolder;

var data: ItemData;
var instruction_time: int
var is_picked: bool = false
var target_position: Vector2 = Vector2.ZERO

func _ready() -> void:
	pass;
	#sprite = $Sprite;

func set_data(d: ItemData):
	data = d;
	progress = d.heat_timer * d.temperature;
	model_holder.set_model(d.raw_model);

func tick(method: MicrowaveMethod):
	if data == null: return;
	var progress_elapse: int = method.temperature;
	if method.duration != 0:
		progress_elapse = method.temperature * method.duration;
	progress -= progress_elapse;
	if (progress <= 0):
		model_holder.set_model(data.cooked_model);

func reset():
	if data == null: return;
	progress = data.heat_timer;
