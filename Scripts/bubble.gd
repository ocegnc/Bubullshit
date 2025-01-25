extends Area2D

var speed = 5  # Number of pixels per frame that the bubble moves
var target_position = Vector2(1000, 0)  # Target position (destination point)
var moving = false  # Flag to determine if the bubble should move

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # You can initialize things here if necessary

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	# If the space key is pressed, we start moving the bubble
	if Input.is_action_just_pressed("ui_accept") and not moving:
		moving = true  # Start moving the bubble

	# If the bubble is moving, move it towards the target
	if moving:
		# Calculate the direction towards the target position
		var direction_to_target = target_position - position
		var distance_to_target = direction_to_target.length()

		# If we are still far from the target position, continue moving
		if distance_to_target > speed:
			# Normalize the direction and move the bubble
			direction_to_target = direction_to_target.normalized()
			position += direction_to_target * speed
		else:
			# If we are close to the target position, stop the bubble
			position = target_position  # Ensure we reach the exact target
			moving = false  # Stop the movement
			

# Function to handle collisions with a piranha
func _on_body_entered(body):
	# Check if the object that collides is a piranha
	if body.is_in_group("piranha"):
		body.reset_position()  # Reset the piranha's position
		position = Vector2(0, 0)  # Reset the bubble's position
		speed = 0  # Stop the bubble's movement
