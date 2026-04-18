extends Node3D
class_name player_visualWithoutSkate

@export var _camera : Camera3D


func _process(_delta):
	var raw_input := Input.get_vector("Left", "Right", "Forward", "Backward")
	var forward := _camera.global_basis.z
	var right := _camera.global_basis.x
	var move_direction := right * raw_input.y + forward * -raw_input.x
	move_direction.y = 0.0
	move_direction = move_direction.normalized()
	if raw_input != Vector2.ZERO:
		look_at(global_position+move_direction)
	else:
		var look_direction := -right + forward
		look_direction.y = 0.0
		look_direction = look_direction.normalized()
		look_at(global_position+look_direction)
