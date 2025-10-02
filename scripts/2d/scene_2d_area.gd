extends Area2D
class_name Scene2DArea

signal player_entered_area(area_name:String)
@export var player_layer_name : String = "SELECT_CUSTOM_LAYER"
@export var area_name : String = "Area Name"

var _player_layer_bit:int

func _ready() -> void:
	_player_layer_bit = _get_layer_bit_from_name(player_layer_name,"2d_physics")
	body_entered.connect(_on_entered)

func _on_entered(body: Node2D):
	if _player_layer_bit == 0:
		return
		
	if body.collision_layer & _player_layer_bit:
		player_entered_area.emit(area_name)
		pass 

func _get_layer_bit_from_name(name: String, physics_type: String) -> int:
	# O caminho para o ProjectSettings é diferente para 2D e 3D
	var setting_path = "layer_names/" + physics_type + "/layer_"
	
	for i in range(1, 33):
		var layer_name = ProjectSettings.get_setting(setting_path + str(i))
		if layer_name == name:
			# Retorna o bit: 1 << (índice - 1)
			# (Ex: Layer 1 -> 1 << 0 = 1; Layer 5 -> 1 << 4 = 16)
			return 1 << (i - 1)
			
	# Retorna 0 se o nome da camada não for encontrado
	return 0
