extends CharacterBody2D

var health = 3
const POSITION = 1000
var bubble_path = preload("res://Scenes/sample_scene.tscn")
var bubble

# Threshold for activating the fart mechanic
const FART_THRESHOLD = 0.8

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	# Find the Control node that has get_audio_level()
	var control_node = get_parent()  # Adjust this path if necessary
	if control_node.has_method("get_audio_level"):
		var audio_level = control_node.get_audio_level()
		if audio_level >= FART_THRESHOLD:
			pass
			fart()

func fart() -> void:
	bubble = bubble_path.instantiate()
	bubble.dir = rotation
	bubble.pos = global_position
	bubble.rota = global_rotation
	get_parent().add_child(bubble)
	


func _on_area_2d_body_entered(body):
	if body.is_in_group("piranha"):  
		body.reset_position()
