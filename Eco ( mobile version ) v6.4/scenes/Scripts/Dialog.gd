extends Control

var dialog_texts : Array = []
var current_dialog_index : int = 0

func start_dialog(texts: Array):
	dialog_texts = texts
	current_dialog_index = 0
	show_next_dialog()

func show_next_dialog():
	if current_dialog_index < dialog_texts.size():
		$Label.text = dialog_texts[current_dialog_index]
		current_dialog_index += 1
	else:
		hide()
		get_node("/root/DialogController").dialog_finished()

func _input(event):
	if event.is_action_pressed("interact"):
		show_next_dialog()
