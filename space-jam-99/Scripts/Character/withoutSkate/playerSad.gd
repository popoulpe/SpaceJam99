extends Node
class_name PlayerWithoutSkate


@onready var character_body_3d = $CharacterBody3D
@export var hud:ui_hud_scientifeet
@export var miniJeux:ui_hud_minijeux

var canInteract :bool = false
var lastInteractableObject :Interactable

func _process(_delta):
	if canInteract && Input.is_action_just_pressed("Interact"):
		lastInteractableObject.Interact(self)

func start_detection_interact(interactable: Interactable, isMiniGame:bool=false) -> void:
	lastInteractableObject = interactable
	canInteract=true
	if isMiniGame:
		miniJeux.show_interact_ui()
	else:
		hud.show_interact_ui()
	
func end_detection_interact(isMiniGame:bool=false) -> void:
	lastInteractableObject = null
	canInteract=false
	if isMiniGame:
		miniJeux.hide_interact_ui()
	else:
		hud.hide_interact_ui()
