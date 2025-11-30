extends Control

class_name MicrowaveInspect

@export var inspect_modal: InspectModal
@export var microwave_ui: BasicMicrowaveUI
@export var close_button: Button

func _ready() -> void:
	close_button.pressed.connect(func(): self.visible = false)

func setup(item: ItemData) -> void:
	inspect_modal.set_display_item(item)
	
