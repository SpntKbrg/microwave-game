extends Node

class_name ItemData

@export var type: UtilType.ItemType;
@export var heat_timer: int; # seconds
@export var temperature: UtilType.WaveTemperature = UtilType.WaveTemperature.LOW;
@export var raw_model: PackedScene
@export var cooked_model: PackedScene

func _init(type, heat_timer, temperature, raw_model, cooked_model) -> void:
	self.type = type;
	self.heat_timer = heat_timer;
	self.temperature = temperature;
	self.raw_model = raw_model;
	self.cooked_model = cooked_model;
	
