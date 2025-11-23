extends Node

@export var microwave_set: Array[MicrowaveSpec]
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
