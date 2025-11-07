extends Area2D

@export var microwave_timer: Timer
@export var microwave_progress: ProgressBar

var microwave_index: int
var timer_input := 0
var is_running: bool = false

var efficiency: int = 100 # efficiency %
var sec_modifier: int = 60 # 1 = real time, 60 = 1 real sec = 1 game min

var countdown_ms: int
signal do_show_microwave_ui(index: int)


func _ready() -> void:
	microwave_timer.timeout.connect(on_microwave_done)
	body_entered.connect(on_body_entered)


func _process(_delta: float) -> void:
	microwave_progress.visible = is_running
	if not is_running:
		return
	var countdown_sec := countdown_ms / 1000.0
	var percent = (countdown_sec -  microwave_timer.time_left) / countdown_sec
	microwave_progress.value = percent * 100.0


func on_item_dropped(item: RigidBody2D, timer: int) -> void:
	if is_running:
		return
	timer_input = timer
	do_show_microwave_ui.emit(microwave_index)
	# TODO UI input
	on_microwave_start() # delete me
	item.queue_free() # delete me


func on_microwave_start() -> void:
	is_running = true
	var input_min_in_sec := floori(timer_input / 100.0) * 60
	var input_sec := timer_input % 100
	countdown_ms = floori((input_min_in_sec + input_sec) * 1000.0 / sec_modifier / efficiency * 100.0) # realtime til finished
	microwave_timer.start(countdown_ms / 1000.0)


func on_microwave_done() -> void:
	is_running = false
	pass


func on_body_entered(target: Node) -> void:
	print(target.name)
	if target.has_method("get_instruction"):
		on_item_dropped(target, target.get_instruction())
