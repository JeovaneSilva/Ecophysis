extends Node

#var dialog_scene : PackedScene
#var video_scene : PackedScene
#var dialog_instance

#func _ready():
#	dialog_scene = load("res://Dialog.tscn")
#	video_scene = load("res://Video.tscn")
#	start_dialog()

#func start_dialog():
	dialog_instance = dialog_scene.instance()
	add_child(dialog_instance)
	dialog_instance.start_dialog(["Primeira parte do diálogo.", "Segunda parte do diálogo."])

#func dialog_finished():
	remove_child(dialog_instance)
	play_video()

#func play_video():
	var video_instance = video_scene.instance()
	add_child(video_instance)
	video_instance.connect("finished", self, "video_finished")

#func video_finished():
	remove_child(get_child(0))
