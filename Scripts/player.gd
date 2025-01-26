extends CharacterBody2D

var health = 3
const MAX_HEALTH = 3

var new_scene: PackedScene = preload("res://Scenes/game.tscn")
const POSITION = 1000
var bubble_path = preload("res://Scenes/sample_scene.tscn")
var bubble

#Called heart container
@onready var heart_container = get_parent().get_node("CanvasLayer/HBoxContainer")

#invicibility during 1s after collision
const INVINCIBILITY_TIME = 1
var is_invincible = false 

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

func life_lost() -> void:
	if not is_invincible:
		health -= 1
		update_hearts()
		if health <= 0:
			game_over()
		else:
			become_invincible()

#player becomes temporarely invicible after collision
func become_invincible() -> void:
	is_invincible = true
	await get_tree().create_timer(INVINCIBILITY_TIME).timeout
	is_invincible = false

#Change life with a broken_heart
func update_hearts() -> void:
	for i in range(MAX_HEALTH):
		var heart = heart_container.get_child(i)
		if i < health:
			heart.texture = preload("res://Assets/heart_icon.png")
		else:
			heart.texture = preload("res://Assets/broken_heart_icon.png")
	

func _on_area_2d_body_entered(body):
	if body.is_in_group("piranha") and not is_invincible:  
		body.reset_position()
		life_lost()

func game_over() -> void:
	var game_over_screen = get_parent().get_node("CanvasLayer/GameOverScreen")
	game_over_screen.visible = true
	
	await get_tree().create_timer(2.0).timeout
	
	get_tree().change_scene(new_scene)
