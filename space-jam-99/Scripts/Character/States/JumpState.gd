extends State

@export var fall_jump_state : State
@onready var skate_particle: CPUParticles3D = $"../../Mesh/skate_anim_V2/Armature/Skeleton3D/Plane/SkateParticle"
@onready var jump: Node = $"."

@export var turnSpeed :float=0.25

func enter() -> void :
	super()
	skate_particle.emitting = false;
	pass

func exit() -> void:
	pass

func process_input(_event:InputEvent) -> State:
	return null

func process_frame(_delta:float) -> State:
	return null

func process_physics(delta:float) -> State:
	floor_snap_adaptation()
	parent.velocity.y += jumpForce # *parent.get_floor_normal()

	
	parent.velocity = apply_forward_deceleration(delta)
	parent.rotation.y = apply_turn_movement(delta, turnSpeed)
	
	return fall_jump_state
