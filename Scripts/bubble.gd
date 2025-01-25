extends Area2D

var speed = 5  # Nombre de pixels par frame que la bulle se déplace
var target_position = Vector2(1000, 0)  # Position cible (point de destination)
var moving = false  # Flag pour savoir si la bulle doit se déplacer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # Vous pouvez initialiser ici si nécessaire

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	# Si la touche espace est appuyée, on commence à déplacer la bulle
	if Input.is_action_just_pressed("ui_accept") and not moving:
		moving = true  # On commence à déplacer la bulle

	# Si la bulle est en mouvement, on la déplace vers la cible
	if moving:
		# Calculer la direction vers le point cible
		var direction_to_target = target_position - position
		var distance_to_target = direction_to_target.length()

		# Si on est encore loin du point cible, continuer à se déplacer
		if distance_to_target > speed:
			# Normaliser la direction et déplacer la bulle
			direction_to_target = direction_to_target.normalized()
			position += direction_to_target * speed
		else:
			# Si on est très près du point cible, on arrête la bulle
			position = target_position  # S'assurer qu'on atteint exactement la cible
			moving = false  # Arrêter le mouvement
			


# Fonction de gestion des collisions avec un piranha
func _on_body_entered(body):
	# Vérifie si l'objet qui entre en collision est un piranha
	if body.is_in_group("piranha"):
		body.reset_position()  # Réinitialise la position du piranha
		position = Vector2(0, 0) 
		speed = 0
		
	
