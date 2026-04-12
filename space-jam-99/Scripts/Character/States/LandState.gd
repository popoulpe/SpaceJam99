extends State

@export var idle_state : State

@export var turnSpeed :float=1

func enter() -> void :
	pass

func exit() -> void:
	pass

func process_input(_event:InputEvent) -> State:
	return null

func process_frame(_delta:float) -> State:
	return null

func process_physics(delta:float) -> State:
	
	parent.velocity = apply_forward_deceleration(delta)
	parent.rotation.y = apply_turn_movement(delta, turnSpeed)
	
	return idle_state
