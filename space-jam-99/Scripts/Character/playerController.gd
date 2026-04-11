extends CharacterBody3D

@onready var pushTimer := $PushTimer


@export var pushMaxSpeed :float= 1
@export var pushAcceleration :float= 10

@export var decelerationDefault :float = 0.1

@export var jumpMaxHeight :float= 1
@export var gravity :float= 1

@export var turnAngleMax :float=1
@export var turnAngleSpeed :float=1

@export var facingAngleMax :float =1
@export var facingAngleSpeed :float =1

var horizontalDir :int= 0
var forwardState :int= 0
var breakState :int = 0
var shouldJump :bool=false

var canPush :bool = true

func _physics_process(delta: float) ->void:
	input()
	#print("avant: ", velocity) 
	velocity = forwardMovement(delta)
	#print("apres: ", velocity)
	rotation.y = turnMovement(delta)
	print("actual speed ", Vector3(velocity.x, 0,velocity.z).length())
	move_and_slide()
	

func input():
	horizontalDir = int(Input.get_action_strength("Left") - Input.get_action_strength("Right"))
	forwardState = int(Input.get_action_strength("Forward"))
	breakState = int(Input.get_action_strength("Backward"))
	shouldJump = Input.is_action_pressed("Jump")
	
func forwardMovement(delta: float) ->Vector3 :
	var forwardVelocity :Vector3= Vector3(velocity.x, 0,velocity.z) 
	
	if forwardState != 0 && canPush:
		forwardVelocity +=(basis.x * forwardState * pushAcceleration)
		canPush = false
		pushTimer.start()
	else:
		forwardVelocity = basis.x * forwardVelocity.length()
		
	forwardVelocity = forwardVelocity.move_toward(Vector3(0,0,0), decelerationDefault)
	
	return forwardVelocity
	
func turnMovement(delta:float) -> float:
	var newDir := rotation.y
	newDir += horizontalDir*turnAngleSpeed*delta
	return newDir


func _on_push_timer_timeout():
	canPush = true
