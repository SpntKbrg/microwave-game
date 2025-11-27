extends Node2D

@export var data: Dictionary[UtilType.ItemType, ModelData];

func getModel(type: UtilType.ItemType):
	return data[type];
