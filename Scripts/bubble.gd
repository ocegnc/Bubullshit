extends Area2D

var speed = 1
var direction = Vector2(1000,0)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	if Input.is_action_just_pressed("ui_accept"):
		
		position += direction * speed * delta

func _on_body_entered(body):
	if body.is_in_group("piranha"):                                             
		body.reset_position()
