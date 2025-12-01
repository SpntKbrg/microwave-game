class_name SoundManager
extends Node


static var __instance: SoundManager = null
var layers: Dictionary[String, SoundQueue] = {}

static func get_instance() -> SoundManager:
	return __instance

func add_sound_layer(layer_name: String, concurrent_players: int) -> void:
	var created := SoundQueue.new(concurrent_players, layer_name)
	add_child(created)
	layers[layer_name] = created

func play_sound(layer: String, sound: AudioStream) -> void:
	if not layers.has(layer):
		return
	var queue := layers.get(layer) as SoundQueue
	queue.queue_audio(sound)

func _ready() -> void:
	__instance = self


func set_vol(vol: float, layer: String = "") -> void:
	for layer_name in layers:
		if layer == "" or layer == layer_name:
			layers[layer_name].set_volume(vol)
