extends Node
class_name PlayerWithoutSkate


@onready var character_body_3d = $CharacterBody3D
@export var hud:ToDeleteHud

var canInteract :bool = false
var lastInteractableObject :Interactable

func _process(_delta):
	if canInteract && Input.is_action_just_pressed("Interact"):
		lastInteractableObject.InteractWithoutSkate(self)

func start_detection_interact(interactable: Interactable) -> void:
	lastInteractableObject = interactable
	canInteract=true
	hud.show_interact_ui()
	
func end_detection_interact() -> void:
	lastInteractableObject = null
	canInteract=false
	hud.hide_interact_ui()
