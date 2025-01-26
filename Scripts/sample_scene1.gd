extends Control

var speed = 3  # Nombre de pixels par frame que la bulle déplace
var target_position = Vector2(1000, 0)  # Position cible (point de destination)
var moving = false  # Drapeau pour déterminer si la bulle doit bouger
var is_bubble_scale_frozen : bool = false  # Indique si la bulle est gelée
var frozen_bubble_scale: Vector2 = Vector2.ONE  # Stocke la taille gelée de la bulle


@onready var recording_player = $recording_player
@onready var mic_input = $mic_input
@onready var bubble = $bubble


var record_bus_index: int
var record_effect
var recording: AudioStreamWAV
var last_position: Vector2 



func _ready() -> void:
	
			
	record_bus_index = AudioServer.get_bus_index('Record')
	# Only one effect on the bus, so can just assume index 0 for record effect
	record_effect = AudioServer.get_bus_effect(record_bus_index, 0)
	record_live_index = AudioServer.get_bus_index('Record')
	spectrum_analyzer = AudioServer.get_bus_effect_instance(record_live_index, 1)



const MIN_DB: int = 80

var record_live_index: int
var volume_samples: Array = []
var frequency_samples: Dictionary = {}
var spectrum_analyzer
var samples_spinbox: int=30
	
	
	
func _process(_delta: float) -> void:
	print(position)
	if Input.is_action_just_pressed("ui_accept") and not moving:  # "ui_accept" is mapped to the spacebar by default
		press_space_to_froze_scale()
		press_space_to_release()
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
			moving = false  # Arrêter le mouvement

	# Only update the bubble size if it's not frozen
	if not is_bubble_scale_frozen:
		update_samples_strength()


func update_samples_strength() -> void:
	var sample = db_to_linear(AudioServer.get_bus_peak_volume_left_db(record_live_index, 0))
	volume_samples.push_front(sample)
	var sample_avg = average_array(volume_samples)
	bubble.scale.x = -1*sample_avg
	bubble.scale.y = -1*sample_avg
	while volume_samples.size()>samples_spinbox:
		volume_samples.pop_back()

	# Use a while loop that way the user can adjust the number of samples at runtime
	# and remove as many as needed when the value changes
	#while volume_samples.size()>samples_spinbox:
	#	volume_samples.pop_back()

func average_array(arr: Array) -> float:
	var avg = 0.0
	for i in range(arr.size()):
		avg += arr[i]
	avg /= arr.size()
	return avg



func _on_amp_spinbox_value_changed(value: float) -> void:
	mic_input.volume_db = linear_to_db(value)


# New function to toggle freezing the bubble's size
func press_space_to_froze_scale() -> void:
	#is_bubble_frozen = not is_bubble_frozen
	is_bubble_scale_frozen!=is_bubble_scale_frozen
	if is_bubble_scale_frozen==true:
		# Store the current scale of the bubble when freezing
		frozen_bubble_scale = bubble.scale
	else:
		# Restore the current size if unfreezing
		bubble.scale = frozen_bubble_scale
		#bubble.scale = Vector2(0,0)

func press_space_to_release():
	moving=true

# Fonction pour configurer les paramètres de la bulle
func setup_bubble(frozen: bool, scale: Vector2) -> void:
	is_bubble_scale_frozen = frozen
	frozen_bubble_scale = scale
	if is_bubble_scale_frozen:
		scale = frozen_bubble_scale  # Applique la taille gelée
	else:
		scale = Vector2.ONE  # Taille normale si la bulle n'est pas gelée
	# Appliquer la taille à la bulle
	self.scale = scale
	

# Fonction pour gérer les collisions avec un piranha
func _on_body_entered(body):
	# Vérifie si l'objet qui entre en collision est un piranha
	
		if body.is_in_group("piranha"):
			
			body.reset_position()  # Réinitialiser la position du piranha
			moving = false
			position = Vector2(-357, 134)  # Reset the bubble's position
			
		
