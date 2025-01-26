extends Control


@onready var recording_player = $recording_player
@onready var mic_input = $mic_input
@onready var bubble = $bubble


var record_bus_index: int
var record_effect
var recording: AudioStreamWAV
var is_bubble_frozen: bool = false  # Track if the bubble size is frozen
var frozen_bubble_scale: Vector2 = Vector2.ONE  # Store the frozen size of the bubble
var last_position: Vector2 


func _ready() -> void:
	record_bus_index = AudioServer.get_bus_index('Record')
	# Only one effect on the bus, so can just assume index 0 for record effect
	record_effect = AudioServer.get_bus_effect(record_bus_index, 0)
	record_live_index = AudioServer.get_bus_index('Record')
	spectrum_analyzer = AudioServer.get_bus_effect_instance(record_live_index, 1)



const MIN_DB: int = 80

var record_live_index: int
var volume_samples: Array = []
var frequency_samples: Dictionary = {}
var spectrum_analyzer



#func _process(_delta: float) -> void:
	#update_samples_strength()

	
	
	
func _process(_delta: float) -> void:
	# Detect spacebar press to toggle freeze
	if last_position!=bubble.position and bubble.position== Vector2.ZERO :
		print("return at the begining")
	if Input.is_action_just_pressed("ui_accept") and last_position!=bubble.position:  # "ui_accept" is mapped to the spacebar by default
		toggle_bubble_freeze()

	# Only update the bubble size if it's not frozen
	if not is_bubble_frozen:
		update_samples_strength()


func update_samples_strength() -> void:
	var sample = db_to_linear(AudioServer.get_bus_peak_volume_left_db(record_live_index, 0))
	volume_samples.push_front(sample)

	# Use a while loop that way the user can adjust the number of samples at runtime
	# and remove as many as needed when the value changes


	var sample_avg = average_array(volume_samples)
	bubble.scale.x = -1*sample_avg
	bubble.scale.y = -1*sample_avg


func average_array(arr: Array) -> float:
	var avg = 0.0
	for i in range(arr.size()):
		avg += arr[i]
	avg /= arr.size()
	return avg




func _on_amp_spinbox_value_changed(value: float) -> void:
	mic_input.volume_db = linear_to_db(value)


# New function to toggle freezing the bubble's size
func toggle_bubble_freeze() -> void:
	is_bubble_frozen = not is_bubble_frozen
	if is_bubble_frozen:
		# Store the current scale of the bubble when freezing
		frozen_bubble_scale = bubble.scale
	else:
		# Restore the current size if unfreezing
		bubble.scale = frozen_bubble_scale
#		bubble.scale = Vector2(0,0)
