extends Camera3D

@export var camera_follow_point : Node3D
@export var character_body_3d : PlayerController

@export var highSpeedFov :float = 150
@export var lowSpeedFov :float = 100
@export var highSpeedValue:float= 40
@export var lowSpeedValue:float= 15
@export var fovAcceleration:float = 10


func _physics_process(delta):
	var speed :float= character_body_3d.velocity.length()
	if speed < lowSpeedValue:
		fov = lowSpeedFov
	elif speed > highSpeedValue:
		fov = highSpeedFov
	else:
		var nextfov = lowSpeedFov + ((highSpeedFov-lowSpeedFov) * ((speed-lowSpeedValue)/(highSpeedFov-lowSpeedFov)))
		fov = lerpf(fov, nextfov, fovAcceleration*delta)
