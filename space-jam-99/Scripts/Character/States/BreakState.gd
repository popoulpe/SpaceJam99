extends State

@export var idle_state : State
@export var jump_state : State
@export var fall_state : State

@export var turnSpeed :float=1
@export var deceleration :float=30

func enter() -> void :
	pass

func exit() -> void:
	pass

func process_input(event:InputEvent) -> State:
	if !Input.is_action_pressed("Backward") :
		return idle_state
	if Input.is_action_pressed("Jump") && parent.is_on_floor():
		return jump_state
	return null

func process_frame(delta:float) -> State:
	return null

func process_physics(delta:float) -> State:
	
	parent.velocity = apply_slope_slide(delta)
	
	if parent.velocity.length()>0:
		parent.velocity = apply_forward_deceleration(delta, deceleration)
	
	if !parent.is_on_floor():
		return fall_state
	return null
