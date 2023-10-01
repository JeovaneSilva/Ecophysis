#Codigos feitos por Kayo Rodrigues ( infor 2 ) 
extends CharacterBody2D


const SPEED = 90.0
const JUMP_VELOCITY = -320.0


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jumping := false
var direction
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
