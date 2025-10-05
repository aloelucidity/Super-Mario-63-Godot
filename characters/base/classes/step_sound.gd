class_name StepPlayer
extends AudioStreamPlayer


@export var default_step: AudioStream
var playback: AudioStreamPlaybackPolyphonic


func _ready() -> void:
	play()
	playback = get_stream_playback()


func play_step() -> void:
	if is_instance_valid(playback):
		playback.play_stream(default_step)
