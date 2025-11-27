extends Node2D

class_name ModelResource

@export var data: Dictionary[UtilType.ItemType, ModelData];

func getModel(type: UtilType.ItemType):
	return data[type];
