extends StateWithoutSkate

@export var _camera:Camera3D

@export var idle_state : StateWithoutSkate
@export var jump_state : StateWithoutSkate

@export var speed :float=1

func process_input(_event:InputEvent) -> StateWithoutSkate:
	if !GlobalScript.canMove:
		return idle_state
	if !(Input.is_action_pressed("Forward") ||
		Input.is_action_pressed("Backward") ||
		Input.is_action_pressed("Left") ||
		Input.is_action_pressed("Right")):
		return idle_state
	if Input.is_action_pressed("Jump") && parent.is_on_floor():
		return jump_state
	return null

func process_physics(delta:float) -> StateWithoutSkate:
	if !GlobalScript.canMove:
		return idle_state
	basic_mouvement(delta)
	apply_gravity(delta)
	return null


func basic_mouvement(delta: float) -> void:
	var raw_input := Input.get_vector("Left", "Right", "Forward", "Backward")
	var forward := _camera.global_basis.z
	var right := _camera.global_basis.x
	var move_direction := forward * raw_input.y + right * raw_input.x
	move_direction.y = 0
	move_direction = move_direction.normalized()
	move_direction.y = parent.velocity.y
	parent.velocity = move_direction * speed *delta
	
