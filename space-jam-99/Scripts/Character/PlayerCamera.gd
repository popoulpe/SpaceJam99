extends Node

@export var camera : Camera3D
@export var springArm : SpringArm3D
@export var character_body_3d : PlayerController

@export var max_down_angle :Vector3 = Vector3(25,-90,0)
@export var max_left_angle :Vector3 = Vector3(0,-130,0)
@export var max_right_angle :Vector3 = Vector3(0,-50,0)
@export var max_up_angle :Vector3 = Vector3(-35,-90,0)
@export var default_angle :Vector3 = Vector3(0,-90,0)

@export var angleSpeed:float= 2

@export var highSpeedFov :float = 150
@export var lowSpeedFov :float = 100
@export var highSpeedValue:float= 60
@export var lowSpeedValue:float= 25
@export var fovAcceleration:float = 10
@onready var speed_camera_particle: CPUParticles3D = $SpeedCameraParticle


func _physics_process(delta):
	adapt_fov(delta)
	#adapt_horizontal_cam(delta)
	#deg_to_rad()


func adapt_fov(delta :float) -> void:
	var speed :float= character_body_3d.velocity.length()
	if speed < lowSpeedValue:
		speed_camera_particle.emitting=false;
		camera.fov = lowSpeedFov
	elif speed > highSpeedValue:
		speed_camera_particle.emitting=true;
		camera.fov = highSpeedFov
	else:
		var nextfov = lowSpeedFov + ((highSpeedFov-lowSpeedFov) * ((speed-lowSpeedValue)/(highSpeedFov-lowSpeedFov)))
		camera.fov = lerpf(camera.fov, nextfov, fovAcceleration*delta)


func adapt_horizontal_cam(delta:float):
	if character_body_3d.horizontalDir<0:
		print("right ?")
		springArm.position.z = abs(springArm.position.z)
		springArm.rotation.y = lerp(springArm.rotation.y, max_right_angle.y, angleSpeed*delta)
	else:
		springArm.position.z = -abs(springArm.position.z)
		springArm.rotation.y = lerp(springArm.rotation.y, max_left_angle.y, angleSpeed*delta)
