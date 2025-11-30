extends Node

class_name ItemFactory

@onready var model_resource: ModelResource = $"ModelResource"

func generate_order() -> Array[ItemData]:
	var items: Array[ItemData] = []
	var order_count = randi_range(1, 4)
	for i in range(order_count):
		var type = randi_range(UtilType.ItemType.STEAK, UtilType.ItemType.ICE_CREAM)
		var heat_timer = randi_range(3, 10)
		var temperature = randi_range(UtilType.WaveTemperature.LOW, UtilType.WaveTemperature.HIGH)
		var models = model_resource.getModel(type)
		items.append(ItemData.new(type, heat_timer, temperature, models.raw_model, models.cooked_model))
	return items
