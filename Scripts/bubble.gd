extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#func _on_area2d_body_entered(body):
	#if body.is_in_group("piranhas"):
		#body.reset_position()


func _on_body_entered(body):
	if body.is_in_group("piranha"):
		body.reset_position()
