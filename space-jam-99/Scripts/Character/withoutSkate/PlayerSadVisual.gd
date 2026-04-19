extends Node3D
class_name player_visualWithoutSkate

@export var _camera : Camera3D
@export var rotationSpeed:float=10

func _process(delta):
	var raw_input := Input.get_vector("Left", "Right", "Forward", "Backward")
	var forward := _camera.global_basis.z
	var right := _camera.global_basis.x
	var move_direction := right * raw_input.y + forward * -raw_input.x
	move_direction.y = 0.0
	move_direction = move_direction.normalized()
	var look_direction
	if raw_input != Vector2.ZERO:
		look_direction = move_direction
	else:
		look_direction = -right + forward
		look_direction.y = 0.0
		look_direction = look_direction.normalized()
	look_direction = Vector3.FORWARD.signed_angle_to(look_direction, Vector3.UP)
	global_rotation.y = lerp_angle(rotation.y, look_direction, rotationSpeed*delta)
