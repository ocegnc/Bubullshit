extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Fonction pour gérer les collisions avec un piranha
func _on_body_entered(body):
	get_parent()._on_body_entered(body)
	
	
		
