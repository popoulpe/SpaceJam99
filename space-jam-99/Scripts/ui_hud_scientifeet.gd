extends Control
class_name ui_hud_scientifeet

@onready var character_body_3d = $".."
@onready var interactPanel = $Control/Panel
@onready var panel_scientifeet = $"Control/panel du scientifeet"
@onready var control_scientifeet = $Control
@onready var label_scientifeet = $"Control/panel du scientifeet/Label"

# nb interaction est supprimable
#c'est juste du test pour montrer que ca marche
var nbInteractions :int=0 

func show_interact_ui():
	control_scientifeet.visible = true

func hide_interact_ui():
	control_scientifeet.visible = false

func interact() -> void:
	interactPanel.visible = false
	panel_scientifeet.visible = true
	nbInteractions+=1
	label_scientifeet.text = "interagi " + str(nbInteractions) + " fois"
