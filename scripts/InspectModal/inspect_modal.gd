extends Control

@export_group("Internal")
@export var __item_scene: ItemScene
@export var __rotation_input: InputHandler


func _ready() -> void:
	__item_scene.reset_rotation()


func _process(_delta: float) -> void:
	__do_rotation_input()


func __do_rotation_input() -> void:
	var rotation_val := __rotation_input.get_input()
	if rotation_val.is_zero_approx():
		return
	__item_scene.add_rotation(rotation_val)
