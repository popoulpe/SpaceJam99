extends State

@export var walk_state : State
@export var jump_state : State

func process_input(_event:InputEvent) -> State:
	if (Input.is_action_pressed("Forward") ||
		Input.is_action_pressed("Backward") ||
		Input.is_action_pressed("Left") ||
		Input.is_action_pressed("Right")):
		return walk_state
	if Input.is_action_pressed("Jump") && parent.is_on_floor():
		return jump_state
	return null

func process_physics(delta:float) -> State:
	
	parent.velocity.x =  0
	parent.velocity.z = 0
	apply_gravity(delta)
	return null
