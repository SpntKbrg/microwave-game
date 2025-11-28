extends Node

@export var microwave_set: Array[MicrowaveSpec]
@export var spawn_timer: Timer
@export var spawn_interval_ms: int
@export var spawn_point: Node
@export var model_resource: ModelResource
@export var item_scene: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var microwave_factory = MicrowaveFactory.new();
	var offset = 0.0;
	for microwave in microwave_set:
		print("create microwave")
		var mw = microwave_factory.create(microwave);
		mw.position = Vector2(0.0 + offset,50.0)
		add_child(mw)
		offset += 50.0;
	spawn_timer.timeout.connect(on_spawn_item)
	spawn_timer.start(spawn_interval_ms / 1000.0)

# todo: need spawn from customer order
func on_spawn_item():
	var model_data = model_resource.getModel(UtilType.ItemType.STEAK);
	var item_data = ItemData.new(UtilType.ItemType.STEAK, 5, UtilType.WaveTemperature.MEDIUM, model_data.raw_model, model_data.cooked_model);
	var model = item_scene.instantiate() as ItemModel
	model.set_data(item_data)
	model.position = Vector2.ZERO
	spawn_point.add_child(model)
	spawn_timer.start(spawn_interval_ms / 1000.0)
