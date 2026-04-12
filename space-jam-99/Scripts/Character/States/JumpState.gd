extends State

@export var fall_state : State

@export var turnSpeed :float=1

func enter() -> void :
	pass

func exit() -> void:
	pass

func process_input(event:InputEvent) -> State:
	return null

func process_frame(delta:float) -> State:
	return null

func process_physics(delta:float) -> State:
	parent.velocity.y += jumpForce # *parent.get_floor_normal() 
	
	parent.velocity = apply_forward_deceleration(delta)
	parent.rotation.y = apply_turn_movement(delta, turnSpeed)
	
	return fall_state
