extends Area3D
class_name Scene3DArea

signal player_entered_area(area_name:String)
@export var area_name : String = "Area Name"

func _ready() -> void:
	body_entered.connect(_on_entered)

func _on_entered(body: Node3D):
	player_entered_area.emit(area_name)
