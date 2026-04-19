extends Node
class_name Player


@onready var character_body_3d = $CharacterBody3D
@export var hud:ui_hud_speed
@export var hud_pause_menu: Control
@export var timePenality :float = 10
@export var invulnerabilityDuration:float=2 
@onready var particle_explozion: CPUParticles3D = $CharacterBody3D/Mesh/ParticleExplozion



var time :float = 0

func _ready():
	GlobalScript.hideMouse()
	
func _process(delta):
	time+=delta
	hud.time_update(time, false)

func get_hit():
	time += timePenality
	hud.time_update(time, true)
	particle_explozion.emitting=true;
