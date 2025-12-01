class_name ItemShelfButton
extends Button


@export var __item_icon: TextureRect
@export var __item_time_hint: Label


func setup(item: ItemResource) -> void:
	__item_icon.texture = item.icon
	__item_time_hint.text = "%.1f-%.1f" % [
		floori(item.timer_min_second / 60.0 * 10) / 10.0,
		floori(item.timer_max_second / 60.0 * 10) / 10.0
	]
