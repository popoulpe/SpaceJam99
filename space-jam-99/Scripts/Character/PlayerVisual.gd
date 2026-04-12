extends Node3D

@export var playerController :PlayerController

@export var slopeOrientationSpeed :float= 10

func _process(delta):
	if !playerController.is_on_floor():
		return
	
	var normal = playerController.get_floor_normal()
	var forward = -playerController.basis.z

	forward = forward.slide(normal).normalized()

	var right = forward.cross(normal).normalized()
	forward = normal.cross(right).normalized()

	var newBasis = Basis(right, normal, -forward)
	global_transform.basis = lerp(global_transform.basis, newBasis, slopeOrientationSpeed*delta)
