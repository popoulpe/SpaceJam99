extends State

@export var idle_state: State
@export var fall_state: State
@export var jump_state: State
@export var break_state : State
@export var heavy_state : State

@export var turnSpeed :float=0.25
@export var turnAcceleration :float=5
@export var deceleration :float = 10

@export var pushAcceleration :float= 15

func enter() -> void :
	pass

func exit() -> void:
	pass

func process_input(_event:InputEvent) -> State:
	if Input.is_action_pressed("Backward") :
		return break_state
	if Input.is_action_pressed("FallFaster"):
		return heavy_state
	if !Input.is_action_pressed("Forward") :
		return idle_state
	if Input.is_action_pressed("Jump") && parent.is_on_floor():
		return jump_state
	return null

func process_frame(_delta:float) -> State:
	return null

func process_physics(delta:float) -> State:
	floor_snap_adaptation()
	parent.velocity = forwardMovement(delta)
	parent.velocity = apply_forward_deceleration(delta, deceleration)
	parent.rotation.y = apply_turn_movement(delta, turnSpeed)
	parent.velocity = gain_turn_speed(delta, turnAcceleration)
	parent.velocity = apply_slope_slide(delta)
	
	if !parent.is_on_floor():
		return fall_state
	return null


func forwardMovement(_delta: float) ->Vector3 :
	var forwardVelocity :Vector3= Vector3(parent.velocity.x, 0,parent.velocity.z) 
	
	if parent.canPush && parent.velocity.length()<pushMaxSpeed:
		forwardVelocity +=(parent.basis.x.slide(parent.get_floor_normal()) * pushAcceleration)
		parent.canPush = false
		parent.pushTimer.start()
	
	forwardVelocity.y = parent.velocity.y
	
	return forwardVelocity
