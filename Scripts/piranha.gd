extends CharacterBody2D

var speed = 200.0
var direction = 1  # 1 pour aller à droite, -1 pour aller à gauche

func _physics_process(delta: float) -> void:
	velocity.x = speed * direction  # Applique la vitesse en fonction de la direction
	move_and_slide()
	
	if velocity.x==0 :
		direction*=-1
