extends Area2D

var speed = 5  # Nombre de pixels par frame que la bulle déplace
var target_position = Vector2(1000, 0)  # Position cible (point de destination)
var moving = false  # Drapeau pour déterminer si la bulle doit bouger
var is_bubble_frozen: bool = false  # Indique si la bulle est gelée
var frozen_bubble_scale: Vector2 = Vector2.ONE  # Stocke la taille gelée de la bulle


# Fonction pour configurer les paramètres de la bulle
func setup_bubble(frozen: bool, scale: Vector2) -> void:
	is_bubble_frozen = frozen
	frozen_bubble_scale = scale
	if is_bubble_frozen:
		scale = frozen_bubble_scale  # Applique la taille gelée
	else:
		scale = Vector2.ONE  # Taille normale si la bulle n'est pas gelée
	# Appliquer la taille à la bulle
	self.scale = scale

# Fonction appelée chaque frame. 'delta' est le temps écoulé depuis la dernière frame.
func _process(delta: float):
	# Si la touche espace est pressée, on commence à déplacer la bulle
	if Input.is_action_just_pressed("ui_accept") and not moving:
		moving = true  # Commencer à déplacer la bulle

	# Si la bulle est en mouvement, la déplacer vers la cible
	if moving:
		# Calculer la direction vers la position cible
		var direction_to_target = target_position - position
		var distance_to_target = direction_to_target.length()

		# Si on est encore loin de la position cible, continuer à déplacer
		if distance_to_target > speed:
			# Normaliser la direction et déplacer la bulle
			direction_to_target = direction_to_target.normalized()
			position += direction_to_target * speed
		else:
			# Si on est proche de la position cible, arrêter la bulle
			position = target_position  # S'assurer d'atteindre la cible exacte
			moving = false  # Arrêter le mouvement

# Fonction pour gérer les collisions avec un piranha
func _on_body_entered(body):
	# Vérifie si l'objet qui entre en collision est un piranha
	if body.is_in_group("piranha"):
		body.reset_position()  # Réinitialiser la position du piranha
		position = Vector2(0, 0)  # Reset the bubble's position
		moving = false
		


func _on_body_exited(body) :
	if body.is_in_group("piranha"):
		pass
