# player/Player.gd
extends CharacterBody3D

@export var move_speed = 4.0
@onready var cam = $Camera3D
@onready var label = $Label3D
@onready var sync = $MultiplayerSynchronizer

var look_sensitivity = 0.2
var rotation_x = 0.0

func _ready():
	if is_multiplayer_authority():
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		cam.current = false

func set_pseudo(name: String):
	label.text = name

func _process(delta):
	if not is_multiplayer_authority():
		return

	# Rotation souris
	var mouse_delta = Input.get_last_mouse_velocity() * look_sensitivity * delta
	rotation_x = clamp(rotation_x - mouse_delta.y, -80, 80)
	rotation_degrees.y -= mouse_delta.x
	cam.rotation_degrees.x = rotation_x

func _physics_process(delta):
	if not is_multiplayer_authority():
		return

	var input_dir = Vector3.ZERO
	if Input.is_action_pressed("move_forward"):
		input_dir.z -= 1
	if Input.is_action_pressed("move_back"):
		input_dir.z += 1
	if Input.is_action_pressed("move_left"):
		input_dir.x -= 1
	if Input.is_action_pressed("move_right"):
		input_dir.x += 1

	input_dir = input_dir.normalized().rotated(Vector3.UP, rotation.y)
	velocity = input_dir * move_speed
	move_and_slide()
