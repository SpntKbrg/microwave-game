extends Node

class_name ItemFactory

@onready var model_resource: ModelResource = $"ModelResource"

func generate_order(item_count: int) -> Array[ItemData]:
	var items: Array[ItemData] = []
	for i in range(item_count):
		var type = randi_range(0, UtilType.ItemType.size() - 2) # Exclude Null
		var heat_timer = randi_range(3, 10)
		var temperature = randi_range(UtilType.WaveTemperature.LOW, UtilType.WaveTemperature.HIGH)
		#var models = model_resource.getModel(type)
		items.append(ItemData.new(type, heat_timer, temperature, null, null))
	return items
