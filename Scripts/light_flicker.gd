extends PointLight2D

# Variables for animation
@export var min_energy: float = 0.5  # Minimum light energy
@export var max_energy: float = 2.0  # Maximum light energy
@export var animation_speed: float = 2.0  # Speed of the animation

var time_passed: float = 0.0  # Tracks the elapsed time

func _ready() -> void:
	# Initialize the energy value
	energy = min_energy

func _process(delta: float) -> void:
	# Update elapsed time
	time_passed += delta * animation_speed

	# Smoothly oscillate energy using a sine wave
	energy = lerp(min_energy, max_energy, (sin(time_passed) + 1.0) / 2.0)
