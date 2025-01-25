extends Node2D

# Exported variables for tweaking in the editor
@export var x_clamp: float = 100.0 # Maximum distance left/right
@export var x_distance_multiplier: float = 1.0 # Multiplier for left/right distance
@export var x_speed: float = 1.0    # Speed of left/right movement

@export var y_clamp: float = 50.0 # Maximum distance up/down
@export var y_distance_multiplier: float = 1.0 # Multiplier for up/down distance
@export var y_speed: float = 1.0    # Speed of up/down movement

# Internal variables
var x_time_passed: float = 0.0
var y_time_passed: float = 0.0

func _process(delta: float):
	# Update time_passed for x and y based on their respective speeds
	x_time_passed += delta * x_speed
	y_time_passed += delta * y_speed

	# Calculate the new x position with clamped oscillation
	var new_x = sin(x_time_passed) * x_clamp * x_distance_multiplier
	new_x = clamp(new_x, -x_clamp, x_clamp)

	# Calculate the new y position with clamped oscillation
	var new_y = cos(y_time_passed) * y_clamp * y_distance_multiplier
	new_y = clamp(new_y, -y_clamp, y_clamp)

	# Apply the new position
	position.x = new_x
	position.y = new_y
