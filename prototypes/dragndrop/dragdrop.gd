extends Node2D


@export var spawn_point: Node2D
@export var item: PackedScene
@export var microwave_ui: Control

@export var microwaves: Array[Area2D]
var microwave_timers: Array[float]
var microwave_is_running: Array[bool]
@onready var microwave_count = len(microwaves)

var added_items: Array[Node2D]

var is_paused := false
@export var game_timer: Timer
@export var spawn_interval_ms := 5000
@export var spawn_min_interval_ms := 1000
@export var spawn_progress := -100


@export var conveyor_belt: Area2D
var items_on_belt: Array[RigidBody2D] = []

func _ready() -> void:
	for i in range(0, microwave_count):
		microwave_is_running.append(false)
		microwave_timers.append(0)
		microwaves[i].body_entered.connect(on_object_entered)
		if microwaves[i].has_signal("do_show_microwave_ui"):
			microwaves[i].do_show_microwave_ui.connect(on_show_microwave_ui)

	game_timer.timeout.connect(on_spawn_object)
	
	game_timer.start(spawn_interval_ms / 1000.0)
	

func _physics_process(delta: float) -> void:
	if is_paused:
		return
	for i in range(0, microwave_count):
		if microwave_timers[i] > 0:
			microwave_timers[i] -= delta
			if microwave_timers[i] < 0:
				microwave_timers[i] = 0

func on_spawn_object() -> void:
	spawn_interval_ms = max(spawn_interval_ms + spawn_progress, spawn_min_interval_ms)
	var temp = item.instantiate() as RigidBody2D
	temp.position = Vector2.ZERO
	spawn_point.add_child(temp)
	added_items.append(temp)
	game_timer.start(spawn_interval_ms / 1000.0)


func on_object_entered(target: Node2D) -> void:
	if target is RigidBody2D:
		target.has_method("")
	pass

func on_show_microwave_ui(index: int) -> void:
	microwave_ui.visible = true
	pass
