extends State

@export var idle_state : State
@export var move_state : State
@export var heavy_state : State

@export var turnSpeed :float= 0.25
@export var deceleration :float = 10
@onready var skate_particle: CPUParticles3D = $"../../Mesh/skate_anim_V2/Armature/Skeleton3D/Plane/SkateParticle"

func enter() -> void :
	skate_particle.emitting=false;
	super()
	pass

func exit() -> void:
	pass

func process_input(_event:InputEvent) -> State:
	if Input.is_action_pressed("FallFaster"):
		return heavy_state
	return null

func process_frame(_delta:float) -> State:
	return null

func process_physics(delta:float) -> State:
	floor_snap_adaptation()
	apply_gravity(delta)
	parent.velocity = apply_forward_deceleration(delta, deceleration)
	parent.rotation.y = apply_turn_movement(delta, turnSpeed)

	if parent.is_on_floor():
		return idle_state
	return null
