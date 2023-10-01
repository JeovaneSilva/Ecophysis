extends CharacterBody2D

var player
var damage_amount : int = 1

func _ready():
	player = get_node("/root/BossFight/Player")

func _physics_process(delta):
	move_towards_player()

func move_towards_player():
	var direction = (player.global_position - global_position).normalized()
	move_and_slide()

func _on_area_entered(area):
	if area.is_in_group("player"):
		player.take_damage(damage_amount)
		queue_free()  # Remova o inimigo
		
