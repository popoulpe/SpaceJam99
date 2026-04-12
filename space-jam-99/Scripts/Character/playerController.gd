extends CharacterBody3D
class_name PlayerController

@onready var pushTimer := $PushTimer

@onready var state_machine = $StateMachine

var canPush :bool = true
var horizontalDir :int=0

func _ready() -> void:
	state_machine.init(self)

func _unhandled_input(event):
	horizontalDir = int(Input.get_action_strength("Left") - Input.get_action_strength("Right"))
	state_machine.process_input(event)

func _physics_process(delta: float) ->void:
	state_machine.process_physics(delta)
	#print("velocity: ", velocity.length(), " real velocity:", get_real_velocity().length())
	move_and_slide()

func _process(delta):
	state_machine.process_frame(delta)

func _on_push_timer_timeout():
	canPush = true
	
