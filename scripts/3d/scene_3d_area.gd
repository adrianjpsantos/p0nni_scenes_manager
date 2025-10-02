extends Area3D
class_name Scene3DArea

signal player_entered_area(area_name:String)
@export var player_layer_name : String = "SELECT_CUSTOM_LAYER"
@export var area_name : String = "Area Name"

var _player_layer_bit:int

func _ready() -> void:
	_player_layer_bit = _get_layer_bit_from_name(player_layer_name,"3d_physics")
	body_entered.connect(_on_entered)

func _on_entered(body: Node3D):
	if _player_layer_bit == 0:
		return
	
	if body.collision_layer & _player_layer_bit:
		player_entered_area.emit(area_name)
	

func _get_layer_bit_from_name(name: String, physics_type: String) -> int:
	var setting_path = "layer_names/" + physics_type + "/layer_"
	
	for i in range(1, 33):
		var layer_name = ProjectSettings.get_setting(setting_path + str(i))
		if layer_name == name:
			return 1 << (i - 1)
	
	return 0
