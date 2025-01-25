extends MarginContainer

@onready var recording_player = $recording_player
@onready var mic_input = $mic_input

var record_bus_index: int
var record_effect: AudioEffectRecord
var recording: AudioStreamWAV

func _ready() -> void:
	record_bus_index = AudioServer.get_bus_index('Record')
	# Only one effect on the bus, so can just assume index 0 for record effect
	record_effect = AudioServer.get_bus_effect(record_bus_index, 0)





func _on_amp_spinbox_value_changed(value: float) -> void:
	mic_input.volume_db = linear_to_db(value)
