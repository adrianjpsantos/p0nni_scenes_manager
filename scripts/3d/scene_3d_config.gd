extends Node3D
class_name Scene3DConfig

signal scene_area_changed(name: String)

@export var scene_name:String = "SCENE_NAME"
@export var start_point : Node3D
@export var scene_areas: Array[Scene3DArea] = []

var _last_player_position : Vector3
var _last_player_rotation : Vector3
var _last_area_visited : String


func _ready() -> void:
	if scene_areas.size() <= 0:
		printerr("A CENA DEVE TER AO MENOS 1 AREA")
		
	if start_point == null:
		printerr("A CENA DEVE TER START_POINT")
	
	for area in scene_areas:
		area.player_entered.connect(_on_player_entered_area)

func set_last_area(area_name:String):
	_last_area_visited = area_name

func get_last_area() -> String:
	return _last_area_visited
	
func set_player_position_on_exit(position: Vector3) -> void:
	_last_player_position = position

func set_player_rotation_on_exit(rotation: Vector3) -> void:
	_last_player_rotation = rotation
	
func _on_player_entered_area(area_name:String) -> void:
	set_last_area(area_name)
	scene_area_changed.emit(area_name)

func register_player_out(player:Node3D) -> void:
	set_player_position_on_exit(player.position)
	set_player_rotation_on_exit(player.rotation)
