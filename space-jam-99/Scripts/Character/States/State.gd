extends Node
class_name State

@export var pushMaxSpeed :float= 15
@export var pushAcceleration :float= 10

@export var decelerationDefault :float = 10

@export var jumpForce :float= 10
@export var gravity :float= -25

@export var slopeDownAcceleration :float = 50
@export var slopeUpAcceleration :float = 1

var parent : PlayerController

func enter() -> void :
	
	pass

func exit() -> void:
	pass

func process_input(_event:InputEvent) -> State:
	return null

func process_frame(_delta:float) -> State:
	return null

func process_physics(_delta:float) -> State:
	return null

func apply_gravity(delta: float) -> void:
	parent.velocity.y += gravity * delta

func apply_forward_deceleration(delta: float, deceleration: float = decelerationDefault) -> Vector3:
	var forwardVelocity :Vector3= Vector3(parent.velocity.x, 0,parent.velocity.z)
	
	forwardVelocity = parent.basis.x * forwardVelocity.length()
	forwardVelocity = forwardVelocity.move_toward(Vector3(0,0,0), deceleration*delta)
	forwardVelocity.y = parent.velocity.y
	
	return forwardVelocity
	
func apply_turn_movement(delta:float, turnSpeed: float) -> float:
	var newDir := parent.rotation.y
	newDir += parent.horizontalDir*turnSpeed*delta
	return newDir

func gain_turn_speed(delta:float, turnAcceleration:float) -> Vector3:
	var newVelocity :Vector3= Vector3(parent.velocity.x, 0,parent.velocity.z) 
	
	if parent.horizontalDir != 0:
		newVelocity += parent.basis.x * turnAcceleration * delta
	
	newVelocity.y = parent.velocity.y
	
	return newVelocity

func apply_slope_slide(delta:float) -> Vector3:
	var floor_slope :Vector3 = parent.get_floor_normal()

	if floor_slope == Vector3.ZERO:
		return parent.velocity
	
	floor_slope = parent.basis.x.slide(floor_slope)
	var slope_speed :float
	
	if floor_slope.y<0:
		slope_speed = floor_slope.y * slopeDownAcceleration
	else:
		slope_speed = floor_slope.y * slopeUpAcceleration
	
	floor_slope = floor_slope.normalized()
	return parent.velocity - (floor_slope * slope_speed * delta)
