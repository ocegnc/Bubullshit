extends CharacterBody2D


const SPEED = 200.0
var direction = 1 #Start to the right


func _physics_process(delta: float) -> void:
	movement()
	move_and_slide()
	
func movement():
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	
func _on_area_2d_area_entered(area: Area2D) -> void:
	direction *= -1
