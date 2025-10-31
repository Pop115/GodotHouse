# player/CameraController.gd
extends Node3D

var look_sensitivity = 0.2
var pitch = 0.0

func _input(event):
	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x * look_sensitivity * 0.01
		pitch = clamp(pitch - event.relative.y * look_sensitivity * 0.01, -1.2, 1.2)
		$Camera3D.rotation.x = pitch
