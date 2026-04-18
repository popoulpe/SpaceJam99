extends Node
class_name StateWithoutSkate

@export var gravity :float= -25

var parent : PlayerControllerWithoutSkate

func enter() -> void :
	pass

func exit() -> void:
	pass

func process_input(_event:InputEvent) -> StateWithoutSkate:
	return null

func process_frame(_delta:float) -> StateWithoutSkate:
	return null

func process_physics(_delta:float) -> StateWithoutSkate:
	return null

func apply_gravity(delta: float, gravityMultiplier:float=1) -> void:
	parent.velocity.y += gravity * delta *gravityMultiplier
