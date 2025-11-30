extends Control

class_name InspectModal

@export_group("Internal")
@export var __item_scene: ItemScene
@export var __rotation_input: InputHandler
@export var __rotation_slider: Slider
@export var __angle_slider: Slider
@export var __close_button: Button

func _ready() -> void:
	__item_scene.reset_rotation()
	__rotation_slider.value_changed.connect(func(_x): __update_slider())
	__angle_slider.value_changed.connect(func(_y): __update_slider())
	__close_button.pressed.connect(func(): visible = false)

func _process(_delta: float) -> void:
	__do_rotation_input()

func __do_rotation_input() -> void:
	var rotation_val := __rotation_input.get_input()
	if rotation_val.is_zero_approx():
		return
	__item_scene.add_rotation(rotation_val)

func __update_slider() -> void:
	var x_degree = __angle_slider.value
	var y_degree = __rotation_slider.value
	__item_scene.set_target_rotation(Vector3(x_degree, y_degree, 0))

func set_display_item(item: ItemData) -> void:
	__item_scene.set_item_model(item.raw_model);
