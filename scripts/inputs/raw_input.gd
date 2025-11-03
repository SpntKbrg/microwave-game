extends InputHandler


@export var input_up: String
@export var input_down: String
@export var input_left: String
@export var input_right: String


func get_input() -> Vector3:
	var value = Input.get_vector(input_left, input_right, input_up, input_down)
	return Vector3(value.x, value.y, 0)
