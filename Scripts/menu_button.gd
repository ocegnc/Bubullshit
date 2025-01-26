extends Button  # Ou tout autre type de nœud parent


func _ready():
	# Créer un bouton dynamique	
	# Connecte le signal 'pressed' au gestionnaire
	pressed.connect(self._button_pressed)

# Fonction appelée quand le bouton est pressé
func _button_pressed():
	# Change la scène pour le jeu
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
	
	
