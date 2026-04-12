extends Control

@onready var character_body_3d = $".."
@onready var label = $Label

func _process(delta):
	label.text = "speed: " + str(snapped(character_body_3d.velocity.length(), 0.01))
