extends RigidBody2D


var instruction_time: int
var is_picked: bool = false
var target_position: Vector2 = Vector2.ZERO

func _ready() -> void:
	instruction_time = ((randi() % 10) + 1) * 100


func _input(event: InputEvent) -> void:
	if not is_picked:
		return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT && not event.pressed:
		print("dropped")
		is_picked = false
	elif event is InputEventMouseMotion:
		handle_on_drag(event)
	
func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			is_picked = event.pressed

func handle_on_drag(event: InputEventMouseMotion) -> void:
	if is_picked:
		target_position = event.position

func _physics_process(delta: float) -> void:
	if is_picked:
		gravity_scale = 0
		linear_damp = 0.99
		constant_force = ((target_position - global_position) * 10000 * delta).limit_length(5000)
	elif target_position != Vector2.ZERO:
		gravity_scale = 1
		linear_damp = 0
		linear_velocity = Vector2.ZERO
		constant_force = Vector2.ZERO
		target_position = Vector2.ZERO
	

