extends State

@export var _camera:Camera3D

@export var walk_state : State
@export var idle_state : State

@export var speed :float=1
@export var jumpHeight :float=13


func process_input(_event:InputEvent) -> State:
	if (parent.is_on_floor() &&
		(Input.is_action_pressed("Forward") ||
		Input.is_action_pressed("Backward") ||
		Input.is_action_pressed("Left") ||
		Input.is_action_pressed("Right"))):
		return walk_state
	
	return null

func process_physics(delta:float) -> State:
	if Input.is_action_pressed("Jump") && parent.is_on_floor():
		parent.velocity.y = jumpHeight
		
	if parent.is_on_floor() && parent.velocity.y == 0:
		return idle_state
		
	basic_mouvement(delta)
	
	apply_gravity(delta)
	return null


func basic_mouvement(delta: float) -> void:
	var raw_input := Input.get_vector("Left", "Right", "Forward", "Backward")
	var forward := _camera.global_basis.z
	var right := _camera.global_basis.x
	var move_direction := forward * raw_input.y + right * raw_input.x
	move_direction.y = 0.0
	move_direction = move_direction.normalized()
	parent.velocity = move_direction * speed *delta
