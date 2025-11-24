extends RigidBody2D


@export var bubble: Control
@export var time_text: Label

var instruction_time: int
var is_picked: bool = false
var target_position: Vector2 = Vector2.ZERO

func _ready() -> void:
	instruction_time = ((randi() % 10) + 1) * 100 + (randi() % 6 ) * 10
	time_text.text = "{0}:{1}".format({ "0": floori(instruction_time / 100.0), "1": "%02d" % (instruction_time % 100) })
	bubble.visible = false

func _input(event: InputEvent) -> void:
	if not is_picked:
		return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT && not event.pressed:
		is_picked = false
	elif event is InputEventMouseMotion:
		handle_on_drag(event)
	
func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			print("item pick");
			is_picked = event.pressed

func handle_on_drag(event: InputEventMouseMotion) -> void:
	if is_picked:
		target_position = event.position

func _physics_process(delta: float) -> void:
	if is_picked:
		gravity_scale = 0
		linear_damp = 0.99
		# constant_force = does not ping other object into orbit, hard to control
		#constant_force = ((target_position - global_position) * 10000 * delta).limit_length(5000)
		# linear_velocity = easy to control, but ping other object away
		linear_velocity = ((target_position - global_position) * delta * 500).limit_length(5000)
		# TODO move placeholder + collision check on release then move original?
	elif target_position != Vector2.ZERO:
		gravity_scale = 1
		linear_damp = 0
		linear_velocity = Vector2.ZERO
		constant_force = Vector2.ZERO
		target_position = Vector2.ZERO

func _process(_delta: float) -> void:
	bubble.visible = is_picked


func is_picked_up() -> bool:
	return is_picked

func get_instruction() -> int:
	return instruction_time
