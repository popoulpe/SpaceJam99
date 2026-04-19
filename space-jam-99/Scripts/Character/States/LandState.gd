extends State

@export var idle_state : State
@onready var skate_particle: CPUParticles3D = $"../../Mesh/skate_anim_V2/Armature/Skeleton3D/Plane/SkateParticle"

func enter() -> void :
	skate_particle.emitting=true;
	super()
	pass

func exit() -> void:
	pass

func process_input(_event:InputEvent) -> State:
	return null

func process_frame(_delta:float) -> State:
	return null

func process_physics(delta:float) -> State:
	floor_snap_adaptation()
	parent.velocity = apply_forward_deceleration(delta)
	
	return idle_state
