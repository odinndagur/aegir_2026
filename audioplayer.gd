extends AudioStreamPlayer

@export var red_light: SpotLight3D
@export var blue_light: SpotLight3D
@export var white_light: SpotLight3D

#AUDIO STUFF
#@onready var spectrum = AudioServer.get_bus_effect_instance(0,0)
var spectrum

var VU_COUNT = 100
const FREQ_MAX = 11050.0

const MIN_DB = 60
#/AUDIO STUFF

var r_energy: float
var w_energy: float
var b_energy: float

var shader_value: float

#var sky_base_top_color = Color(0,0,1,1)
var sky_base_top_color = Color.from_hsv(215,91,46)

func logify(normalized_linear_value):
	var output_logified_value
	if normalized_linear_value < 0.5:
		output_logified_value = normalized_linear_value * 0.2
	else:
		output_logified_value = normalized_linear_value * 1.8 - 0.8
	return output_logified_value



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spectrum = AudioServer.get_bus_effect_instance(0,0)
	pass # Replace with function body.

var multiplier = 3
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var r_magnitude: float = spectrum.get_magnitude_for_frequency_range(1, 100).length()
	r_energy = clamp((MIN_DB + linear_to_db(r_magnitude)) / MIN_DB, 0, 1)
	
	var b_magnitude: float = spectrum.get_magnitude_for_frequency_range(101, 1500).length()
	b_energy = clamp((MIN_DB + linear_to_db(b_magnitude)) / MIN_DB, 0, 1)
	
	var w_magnitude: float = spectrum.get_magnitude_for_frequency_range(1501, FREQ_MAX).length()
	w_energy = clamp((MIN_DB + linear_to_db(w_magnitude)) / MIN_DB, 0, 1)
	
	print(r_energy,w_energy,b_energy)
	
	red_light.light_energy = r_magnitude * multiplier
	blue_light.light_energy = b_magnitude * multiplier
	white_light.light_energy = w_magnitude * multiplier
