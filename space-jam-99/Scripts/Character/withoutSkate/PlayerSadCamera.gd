extends SpringArm3D

@export var sensivity:float=0.08

var _camera_input_direction := Vector2.ZERO

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	

func _unhandled_input(event : InputEvent) -> void:
	var is_camera_motion := (
		event is InputEventMouseMotion and
		Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	)
	if is_camera_motion:
		_camera_input_direction = event.screen_relative * sensivity

func _physics_process(delta: float) -> void:
	rotation.x -= _camera_input_direction.y * delta
	rotation.x = clamp(rotation.x, -PI / 3.0, PI / 3.0)
	rotation.y -= _camera_input_direction.x * delta

	_camera_input_direction = Vector2.ZERO
