class_name Customer

extends Node

var customer_id: int
var patient_time: float = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	patient_time = clampf(patient_time - delta, 0, patient_time)
