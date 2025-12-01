class_name CustomerButton
extends Button

@export_category("Internal")
@export var __timer_progress: ProgressBar
@export var __cart_container: Control
@export var __item_icon_template: PackedScene
var __customer: CustomerUiData
var __is_ticking: bool

signal on_customer_selected(customer_id: int)

func setup(customer: CustomerUiData) -> void:
	__customer = customer
	customer.customer.customer_complete_signal.connect(clean_up)
	customer.customer.customer_patient_time_out_signal.connect(clean_up)
	for item in __customer.cart:
		var item_type := item.type
		var icon_node := __item_icon_template.instantiate()
		var item_icon := icon_node as ItemIcon
		__cart_container.add_child(item_icon)
		item_icon.setup(item_type)
	__is_ticking = true
	pass

func clean_up(_id: int) -> void:
	__is_ticking = false

func _process(_delta: float) -> void:
	if not __is_ticking:
		visible = false
		queue_free()
		return
	__timer_progress.value = __customer.customer.get_current_patient_time_ratio()
	
func get_customer_id() -> int:
	return __customer.customer.customer_id
	
func get_item_icon_list() -> Array:
	return (
		__cart_container.get_children()
			.filter(func (child): return is_instance_of(child, ItemIcon))
			.map(func (child): return child as ItemIcon)
	)

func remove_item_icon_at_index(index: int) -> void:
	if index < 0 or index >= __cart_container.get_child_count():
		push_error("Button::remove_item_icon_at_index : index not found : ", index)
		return
	
	var target_child := __cart_container.get_child(index)

	__cart_container.remove_child(target_child)
	target_child.queue_free()
	
func on_selected() -> void:
	on_customer_selected.emit(get_customer_id())
