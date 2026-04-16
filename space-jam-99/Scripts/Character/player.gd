extends Node
class_name Player


@onready var character_body_3d = $CharacterBody3D
@export var hud:hud
@export var time :float = 60
@export var timePenality :float = 5
@export var invulnerabilityDuration:float=2 

var canInteract :bool = false
var lastInteractableObject :Interactable

func _process(delta):
	if time>0:
		time-=delta
		hud.time_update(time, false)
	elif time>-10:
		time = -10
		print('YOU LOSE !')
	
	if canInteract && Input.is_action_just_pressed("Interact"):
		lastInteractableObject.Interact()

func get_hit():
	if time <=0:
		return
	time -= timePenality
	hud.time_update(time, true)

func start_detection_interact(interactable: Interactable) -> void:
	lastInteractableObject = interactable
	canInteract=true
	hud.show_interact_ui()
	
func end_detection_interact() -> void:
	lastInteractableObject = null
	canInteract=false
	hud.hide_interact_ui()
