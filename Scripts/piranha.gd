extends CharacterBody2D


const SPEED = 200.0
var direction = 1 #Start to the right

func _on_area_2d_area_entered(area: Area2D) -> void:
	direction *= -1
	
func movement():
	velocity.x = direction * SPEED


func _physics_process(delta: float) -> void:
	movement()
	move_and_slide()


func _on_animated_sprite_2d_animation_changed() -> void:
	pass # Replace with function body.
