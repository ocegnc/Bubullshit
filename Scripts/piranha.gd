extends CharacterBody2D

var speed = -200.0
var direction = 1  # 1 right, -1 left
var initial_position

func _ready() -> void:
	initial_position = position
	
func _physics_process(delta: float) -> void:
	velocity.x = speed * direction  
	move_and_slide()

func reset_position() -> void:
	position = initial_position
	velocity = Vector2.ZERO
