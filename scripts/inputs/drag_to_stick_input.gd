extends InputHandler

@export_category("Options")
# false: stop input when input motion stops
# true: keep input until input lift
@export var is_persistent: bool = false
@export var input_area: Transform2D

var __is_dragging := false
var __is_speed_zero := false
var __stored_value := Vector3.ZERO
var __start_point := Vector2.ZERO

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		__handle_mouse_button(event)


func __handle_mouse_button(event: InputEventMouseButton) -> void:
	if event.button_index == MOUSE_BUTTON_LEFT:
		if not __is_dragging and event.pressed:
			__is_dragging = true
			__start_point = event.position
		elif __is_dragging and not event.pressed:
			__is_dragging = false

func __handle_mouse_motion(event: InputEventMouseMotion) -> void:
	if __is_dragging:
		var changed = event.velocity
		if changed.is_zero_approx():
			__is_speed_zero = true
		else:
			__is_speed_zero = false
		#if is_persistent and __is_speed_zero:




func get_input() -> Vector3:
	return __stored_value
