extends Control

@export var customer: Customer
@export var id_label: Label
@export var remain_time_progress_bar: ProgressBar
@export var item_count_label: Label

func _ready() -> void:
	customer.customer_id_update_signal.connect(on_update_id)
	customer.customer_remain_item_count_update_signal.connect(on_update_remain_item_count)

func on_update_id(id: int) -> void:
	id_label.text = str(id)
	position.x = id * 150

func on_update_remain_item_count(item_count: int) -> void:
	item_count_label.text = str(item_count)

func update_remain_time(time_ratio: float) -> void:
	remain_time_progress_bar.value = time_ratio

func _process(delta: float) -> void:
	update_remain_time(clampf(customer.get_current_patient_time_ratio(), 0, 1))
