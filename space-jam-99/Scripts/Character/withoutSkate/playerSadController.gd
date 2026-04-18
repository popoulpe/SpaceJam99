extends CharacterBody3D
class_name PlayerControllerWithoutSkate

@onready var player :Player= $".."
@onready var playerVisual :player_visual= $Mesh

@onready var state_machine = $StateMachine

func _ready() -> void:
	state_machine.init(self)

func _unhandled_input(event):
	state_machine.process_input(event)

func _physics_process(delta: float) ->void:
	state_machine.process_physics(delta)
	
	move_and_slide()

func _process(delta):
	state_machine.process_frame(delta)
