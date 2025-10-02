extends Node
class_name ScenesManager

signal exit_scene
signal enter_scene(scene_name:String)

@export var player_node_name:String
var current_scene : Scene2DConfig
var last_scene : Scene2DConfig

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
	 # 1. Pega o nó raiz da nova cena
	var new_scene_root = get_tree().current_scene
	
	# 2. Faz o casting (conversão de tipo) para Scene2DConfig
	#    'is' verifica se o nó é da classe ou herda dela.
	if new_scene_root is Scene2DConfig:
		# A nova cena é o nosso Scene2DConfig!
		var new_scene_config: Scene2DConfig = new_scene_root
		
		current_scene = new_scene_config
		print("Nova Scene2DConfig carregada: ", current_scene.name)
		
	else:
		# Lógica de fallback se a cena carregada não for um Scene2DConfig
		current_scene = new_scene_root
		printerr("Cena carregada não é um Scene2DConfig!")
	
	enter_scene.emit(current_scene.name)
