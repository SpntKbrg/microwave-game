class_name SoundQueue
extends Node

var _concurrent_players: int
var _audio_bus: String
var __audio_stream_queue : Array[AudioStream] = []
var __queue_pointer: int = 0
var __available_players_stack: Array[AudioStreamPlayer] = []


func _init(concurrent_player: int, audio_bus: String):
	_concurrent_players = concurrent_player
	_audio_bus = audio_bus


func _ready():
	for i in _concurrent_players:
		var player := AudioStreamPlayer.new()
		player.bus = _audio_bus
		add_child(player)
		__available_players_stack.append(player)
		player.finished.connect(func () -> void:
			__on_stream_finished(player)
		)


func __on_stream_finished(player: AudioStreamPlayer):
	# When finished playing a stream, make the player available again.
	__available_players_stack.append(player)


func __get_audio_to_play() -> AudioStream:
	var stream = __audio_stream_queue[__queue_pointer]
	__queue_pointer += 1
	if __queue_pointer == __audio_stream_queue.size():
		clear_queue()
	return stream


func _process(_delta) -> void:
	if (
			__audio_stream_queue.size() == 0
			or __available_players_stack.size() == 0
		):
		return
	var player := __available_players_stack.pop_back() as AudioStreamPlayer
	player.stream = __get_audio_to_play()
	player.play()


func queue_audio(stream: AudioStream) -> void:
	__audio_stream_queue.append(stream)


func clear_queue():
	__queue_pointer = 0
	__audio_stream_queue.clear()


func set_volume(vol: float) -> void:
	for player in get_children():
		if player is AudioStreamPlayer:
			player.volume_linear = vol
