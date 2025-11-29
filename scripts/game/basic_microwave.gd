class_name BasicMicrowave extends IMicrowave

@export var microwave_timer: Timer
@export var microwave_progress: ProgressBar
var item: ItemModel
var countdown_ms: int
var sec_modifier: int = 60 # 1 = real time, 60 = 1 real sec = 1 game min

func setup()->void:
	print("basic microwave seting up..")
	microwave_timer.timeout.connect(on_countdown)
	
func _ready() -> void:
	super._ready()

func _process(_delta: float) -> void:
	microwave_progress.visible = is_running
	if not is_running:
		return
	var countdown_sec := countdown_ms / 1000.0
	var percent = (countdown_sec -  microwave_timer.time_left) / countdown_sec
	microwave_progress.value = percent * 100.0

func on_item_drop_addition(_item: ItemModel) -> void:
	if not microwave_ui.is_connected("on_commit_command", on_commit_command):
		print("connect on_commit_command")
		microwave_ui.on_commit_command.connect(on_commit_command)
	item = _item

func on_countdown()->void:
	is_running = false

func on_commit_command(_command: MicrowaveMethod, _time: int) -> void:
	print("do on_commit_command")
	is_running = true
	var input_min_in_sec := floori(_time / 100.0) * 60
	var input_sec := _time % 100
	countdown_ms = floori((input_min_in_sec + input_sec) * 1000.0 / sec_modifier) # realtime til finished
	microwave_timer.start(countdown_ms / 1000.0)
	item.tick(_command)
