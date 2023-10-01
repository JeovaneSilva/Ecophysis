#Codigos feitos por Kayo Rodrigues ( infor 2 ) 
extends CharacterBody2D


const SPEED = 90.0
const JUMP_VELOCITY = -320.0


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jumping := false
var direction
var player_life: int = 3
var knockback_vector := Vector2.ZERO
var life_count: int = 1
@onready var Life_1 = $health_1
@onready var Life_2 = $health_2
@onready var Life_3 = $Health_3
@onready var texture := $anim as AnimatedSprite2D
@onready var remote_transform := $remote as RemoteTransform2D





func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	direction = Input.get_axis("ui_left", "ui_right")
	
	if direction != 0:
		velocity.x = direction * SPEED
		texture.scale.x = direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if knockback_vector != Vector2.ZERO:
		velocity = knockback_vector
		
	
	_set_state()
	move_and_slide()

#ajuste de camera
func follow_camera(camera):
	var camera_path = camera.get_path()
	remote_transform.remote_path = camera_path

#Solução do pulo mobile
func _input(event):
	if event is InputEventScreenTouch:
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			$Jump.play()
		is_jumping = true
		
	elif is_on_floor():
		is_jumping = false

#declaração de animações
func _set_state():
	var state = "Idle"
	
	#if is_on_floor == false
	if !is_on_floor():
		state = "Jump"
	elif direction != 0:
		state = "Walk"
		
	if texture.name != state:
		texture.play(state)

#konckback/HP
func _on_hurtbox_body_entered(body):
	if life_count == 1:
		life_count += 1
		life_count = life_count
		print(life_count)
		Life_1.queue_free()
	elif life_count == 2:
			life_count += 1
			life_count = life_count
			print(life_count)
			Life_2.queue_free()
	elif life_count == 3:
		life_count += 1
		life_count = life_count
		print(life_count)
		Life_3.queue_free()
	
	
	
	if player_life < 0:
		queue_free()
		
		get_tree().change_scene_to_file("res://scenes/actors/menu.tscn")
	else:
		if $ray_right.is_colliding():
			take_damage(Vector2(200,-200))
		if $ray_left.is_colliding():
			take_damage(Vector2(200,-200))
		
func take_damage(knockback_force := Vector2.ZERO, duration := 0.30):
	player_life -= 2
	
	
	if knockback_force != Vector2.ZERO:
		knockback_vector = knockback_force
		$hurt.play()
		
		var knockback_tween := get_tree().create_tween()
		knockback_tween.parallel().tween_property(self, "knockback_vector", Vector2.ZERO, duration)
		texture.modulate = Color(1,0,0,1)
		knockback_tween.parallel().tween_property(texture, "modulate", Color(1,1,1,1), duration)
		
func _on_Area2D_area_entered(area):
	if area.is_in_group("Player"):
		var player = area
		player.damage()  # Função no script do jogador para levar dano
		
