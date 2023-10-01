extends CharacterBody2D

var slime_enemy_scene : PackedScene
var invocated_slimes : int = 0
var max_invocated_slimes : int = 5
var spawn_interval : float = 5.0
var spawn_timer : Timer

func _ready():
	slime_enemy_scene = preload("res://scenes/actors/minion.tscn")  # Carregar a cena das slimes invocadas
	spawn_timer = $Timer
	spawn_timer.start()

func _on_timer_timeout():
	if invocated_slimes < max_invocated_slimes:
		spawn_slime()

func spawn_slime():
	var slime_instance = slime_enemy_scene.instance()
	add_child(slime_instance)
	invocated_slimes += 1
	slime_instance.connect("slime_died", self, "_on_slime_died")

func _on_slime_died():
	invocated_slimes -= 1
	# Causar dano ao chefe slime aqui


