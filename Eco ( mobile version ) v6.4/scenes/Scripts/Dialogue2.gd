extends Area2D

var dialogue_background : NinePatchRect
var dialogue_label : Label
var player_inside : bool = false
var dialogue_data : Array = []
var current_dialogue_index : int = 0

func _ready():
	dialogue_background = $NinePatchRect
	dialogue_label = $NinePatchRect/Label
	hide_dialogue()

	# Exemplo de diálogo
	dialogue_data = [
		"Motorista:
		Ei garoto",
			"Você não pode sair 
			assim!",
]

func _on_body_entered(body: PhysicsBody2D) -> void:
	if body.is_in_group("player"):
		player_inside = true
		show_dialogue()

func _on_body_exited(body: PhysicsBody2D) -> void:
	if body.is_in_group("player"):
		player_inside = false
		hide_dialogue()

func show_dialogue():
	if player_inside:
		dialogue_label.text = dialogue_data[current_dialogue_index]
		dialogue_background.show()
		dialogue_label.show()

func hide_dialogue():
	dialogue_background.hide()
	dialogue_label.hide()

func _input(event):
	if player_inside and event.is_action_pressed("interact"):
		advance_dialogue()

func advance_dialogue():
	current_dialogue_index += 1
	if current_dialogue_index >= dialogue_data.size():
		current_dialogue_index = 0
	show_dialogue()




	





