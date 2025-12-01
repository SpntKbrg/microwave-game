class_name MicrowaveToggle
extends TextureButton


@export var microwave_timer: Timer
@export var microwave_progress: ProgressBar
@export var anim_sprite: AnimSprite
@export var item_icon: ItemIcon
var is_running: bool = false

var microwave_id: int
var countdown_ms: int
var sec_modifier: int = 60 # 1 = real time, 60 = 1 real sec = 1 game min
var current_command: MicrowaveMethod
var completed_item_type: UtilType.ItemType = UtilType.ItemType.NULL

signal on_wave_timeout(method: MicrowaveMethod)
signal on_microwave_selected(microwave_id: int)

func setup()->void:
	print("basic microwave seting up..")
	anim_sprite.set_animating(false)
	microwave_timer.timeout.connect(on_countdown)
	microwave_progress.visible = false
	item_icon.visible = false

func _process(_delta: float) -> void:
	microwave_progress.visible = is_running
	if not is_running:
		return
	var countdown_sec := countdown_ms / 1000.0
	var percent = (countdown_sec -  microwave_timer.time_left) / countdown_sec
	microwave_progress.value = percent * 100.0

func on_countdown()->void:
	is_running = false
	on_wave_timeout.emit(current_command)
	completed_item_type = current_command.item_type
	current_command = null
	anim_sprite.set_animating(false)
	
func on_complete_order() -> void:
	completed_item_type = UtilType.ItemType.NULL
	item_icon.visible = false

func commit_command(_command: MicrowaveMethod) -> void:
	if is_running:
		print("Microwave is still be used.")
		return
	print("do on_commit_command")
	is_running = true
	current_command = _command
	var input_min_in_sec := floori(_command.duration / 100.0) * 60
	var input_sec := _command.duration % 100
	countdown_ms = floori((input_min_in_sec + input_sec) * 1000.0 / sec_modifier) # realtime til finished
	microwave_timer.start(countdown_ms / 1000.0)
	anim_sprite.set_animating(true)
	item_icon.setup(_command.item_type)
	item_icon.visible = true

func on_selected() -> void:
	on_microwave_selected.emit(microwave_id)
