extends State

@export var move_state : State
@export var fall_state : State
@export var jump_state : State
@export var break_state : State

@export var turnSpeed :float=1
@export var turnAcceleration :float=5
@export var deceleration :float = 15

func enter() -> void :
	pass

func exit() -> void:
	pass

func process_input(event:InputEvent) -> State:
	if Input.is_action_pressed("Backward") :
		return break_state
	if Input.is_action_pressed("Forward") :
		return move_state
	if Input.is_action_pressed("Jump") && parent.is_on_floor():
		return jump_state
	return null

func process_physics(delta:float) -> State:
	
	parent.velocity = apply_forward_deceleration(delta, deceleration)
	parent.rotation.y = apply_turn_movement(delta, turnSpeed)
	parent.velocity = gain_turn_speed(delta, turnSpeed, turnAcceleration)
	parent.velocity = apply_slope_slide(delta)
	
	if !parent.is_on_floor():
		return fall_state
	return null
	
func process_frame(delta:float) -> State:
	return null
