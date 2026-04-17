extends State

@export var idle_state : State
@export var jump_state : State

@export var slopeAccelerationMult :float = 3
@export var gravityMult :float = 2
@export var deceleration :float=30

func enter() -> void :
	super()
	pass

func exit() -> void:
	pass

func process_input(_event:InputEvent) -> State:
	if !Input.is_action_pressed("FallFaster") :
		return idle_state
	if Input.is_action_pressed("Jump") && parent.is_on_floor():
		return jump_state
	return null

func process_frame(_delta:float) -> State:
	return null

func process_physics(delta:float) -> State:
	floor_snap_adaptation()
	apply_gravity(delta, gravityMult)
	#parent.velocity = apply_forward_deceleration(delta, deceleration)
	parent.velocity = apply_slope_slide(delta, slopeAccelerationMult)
	
	return null
