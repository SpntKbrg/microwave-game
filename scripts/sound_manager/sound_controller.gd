class_name SoundController
extends Node


var __sound_manager: SoundManager
static var __instance: SoundController
@export var volume: float
@export var audio_dict: Dictionary[UtilType.SFX, AudioStream] = {}

const SFX_LAYER := "SFX"

var __layer_players_settings: Dictionary[String, int] = {
	SFX_LAYER: 5,
}

func _ready() -> void:
	__sound_manager = SoundManager.get_instance()
	__instance = self
	# VarManager.on_data_changed.connect(_on_var_changed)
	for layer in __layer_players_settings.keys():
		var concurrent_count := __layer_players_settings[layer] as int
		__sound_manager.add_sound_layer(layer, concurrent_count)
	var current_vol = volume
	if current_vol is float and current_vol != null:
		__sound_manager.set_vol(current_vol)
	else:
		__sound_manager.set_vol(0.5)


static func get_instance() -> SoundController:
	return __instance


func __play_layer(key: UtilType.SFX, layer: String) -> void:
	if not audio_dict.has(key):
		var text := "ERR: Audio not found, key: {key}".format({"key": key})
		print(text)
		return
	var target_sound = audio_dict.get(key) as AudioStream
	__sound_manager.play_sound(layer, target_sound)


func play_sound(key: UtilType.SFX) -> void:
	__play_layer(key, SFX_LAYER)
