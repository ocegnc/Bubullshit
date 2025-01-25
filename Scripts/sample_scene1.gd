
extends Control

@onready var recording_player = $recording_player
@onready var mic_input = $mic_input
@onready var bubble = $bubble

var record_bus_index: int
var record_effect: AudioEffectRecord
var recording: AudioStreamWAV

const MIN_DB: int = 80

var record_live_index: int
var volume_samples: Array = []
var frequency_samples: Dictionary = {}
var spectrum_analyzer: AudioEffectSpectrumAnalyzerInstance

func _ready() -> void:
	record_bus_index = AudioServer.get_bus_index('Record')
	record_effect = AudioServer.get_bus_effect(record_bus_index, 1)
	record_live_index = AudioServer.get_bus_index('Record')
	spectrum_analyzer = AudioServer.get_bus_effect_instance(record_live_index, 2)

func _process(_delta: float) -> void:
	update_samples_strength()

func update_samples_strength() -> void:
	var sample = db_to_linear(AudioServer.get_bus_peak_volume_left_db(record_live_index, 0))
	volume_samples.push_front(sample)

	# Maintain a rolling average for better stability
	while volume_samples.size() > 10:  # Keep the last 10 samples
		volume_samples.pop_back()

	var sample_avg = average_array(volume_samples)
	bubble.scale.x = -1 * sample_avg
	bubble.scale.y = -1 * sample_avg

func average_array(arr: Array) -> float:
	var avg = 0.0
	for i in range(arr.size()):
		avg += arr[i]
	avg /= arr.size()
	return avg

func get_audio_level() -> float:
	# Return the average audio level for use by other scripts
	return average_array(volume_samples)
