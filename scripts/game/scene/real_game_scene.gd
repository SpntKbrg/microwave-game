extends Control

@export var microwave_set: Array[MicrowaveSpec]
@export var microwave_spawn_point: Node
@export var item_spawn_point: Node
@export var model_resource: ModelResource
@export var item_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var microwave_factory = MicrowaveFactory.new();
	for microwave in microwave_set:
		var mw = microwave_factory.create(microwave);
		microwave_spawn_point.add_child.call_deferred(mw)
