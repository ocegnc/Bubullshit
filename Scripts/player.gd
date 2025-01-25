extends CharacterBody2D

var health = 3
const POSITION = 1000
var bubble_path=preload("res://Scenes/bubble.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		fart()

func fart():
	var bubble=bubble_path.instantiate()
	bubble.dir=rotation
	bubble.pos=$Node2D.global_position
	bubble.rota=global_rotation
	get_parent().add_child(bubble)
