extends Node
class_name ScenesManager

signal exit_scene
signal enter_scene(scene_name:String)

@export var player_node_name:String
var current_scene : Scene3DConfig
var last_scene : Scene3DConfig

func _ready() -> void:
	get_tree().root.connect("tree_exited", _on_scene_exit)
	
func _on_scene_exit():
	exit_scene.emit()
	var player = get_tree().root.find_child(player_node_name)
	current_scene.register_player_out(player)
	last_scene = current_scene
	print("Sinal 'tree_exited' detectado. Saindo da cena anterior...")
	call_deferred("_on_scene_loaded")

func _on_scene_loaded():
	var new_scene_root = get_tree().current_scene
	
	if new_scene_root is Scene3DConfig:
		var new_scene_config: Scene3DConfig = new_scene_root
		
		current_scene = new_scene_config
		print("Nova Scene3DConfig carregada: ", current_scene.name)
	else:
		current_scene = new_scene_root
		printerr("Cena carregada não é um Scene3DConfig!")
	
	enter_scene.emit(current_scene.name)
