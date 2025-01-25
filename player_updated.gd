
extends CharacterBody2D

var health = 3
const POSITION = 1000
var bubble_path = preload("res://Scenes/sample_scene.tscn")

# Threshold for activating the fart mechanic
const FART_THRESHOLD = 0.8

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	# Fart automatically if the audio input exceeds the threshold
	var audio_level = get_parent().get_audio_level()  # Get audio level from parent
	if audio_level >= FART_THRESHOLD:
		fart()

func fart() -> void:
	var bubble = bubble_path.instantiate()
	bubble.dir = rotation
	bubble.pos = global_position
	bubble.rota = global_rotation
	get_parent().add_child(bubble)
