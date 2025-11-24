extends Node3D

class_name ModelHolder

@onready var holder_parent = $"holder";

var current_model: Node;

func set_model(scene: PackedScene):
	if current_model != null:
		current_model.queue_free();
	current_model = scene.instantiate();
	holder_parent.add_child(current_model);
