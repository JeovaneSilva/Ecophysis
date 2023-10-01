extends Area2D

var player_inside : bool = false

# Indique qual é a próxima fase que o jogador deve avançar
var next_level_scene : String = "res://level/world-2.tscn"

func _ready():
	# Chamado quando o nó está pronto para ser utilizado
	pass

func _on_body_entered(body: PhysicsBody2D) -> void:
	# Chamado quando um corpo entra na área
	if body.is_in_group("player"):
		player_inside = true

func _on_body_exited(body: PhysicsBody2D) -> void:
	# Chamado quando um corpo sai da área
	if body.is_in_group("player"):
		player_inside = false

func _input(event):
	# Chamado quando há uma entrada de teclado
	if player_inside and event.is_action_pressed("interact"):
		advance_to_next_level()

func advance_to_next_level():
	# Carregar a cena da próxima fase e trocar para ela
	if next_level_scene != "":
		get_tree().change_scene_to_file("res://Level/world-2.tscn")

