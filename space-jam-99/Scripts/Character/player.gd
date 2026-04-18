extends Node
class_name Player


@onready var character_body_3d = $CharacterBody3D
@export var hud:ui_hud_speed
@export var time :float = 60
@export var timePenality :float = 5
@export var invulnerabilityDuration:float=2 

func _process(delta):
	if time>0:
		time-=delta
		hud.time_update(time, false)
	elif time>-10:
		time = -10
		print('YOU LOSE !')

func get_hit():
	if time <=0:
		return
	time -= timePenality
	hud.time_update(time, true)
