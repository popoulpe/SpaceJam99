extends Node3D


@export_group("Level Data")
@export var ToDeleteEarth:Node3D
@export var ToDeleteShip:Node3D
@export var OzoneCollision:Area3D
@export var ShipCollision:Area3D

@export_group("Scenes Names")
@export var shipScene:String = "res://Scenes/MainScenes/definitiveScene/ScientifeetShip.tscn"

@export_group("Player Data")
@export var player:Player
@export var earthSpawnPos: Vector3
@export var earthSpawnRot: Vector3
@export var shipSpawnPos: Vector3
@export var shipSpawnRot: Vector3



var isFromEarth:bool


func _ready():
	isFromEarth = GlobalScript.isFromEarth
	if isFromEarth:
		OzoneCollision.queue_free()
		ToDeleteEarth.queue_free()
		player.character_body_3d.position = earthSpawnPos
		player.character_body_3d.rotation = earthSpawnRot
	else:
		ToDeleteShip.queue_free()
		ShipCollision.queue_free()
		player.character_body_3d.position = shipSpawnPos
		player.character_body_3d.rotation = shipSpawnRot



func coucheOzoneAtteinte(_body:Node3D) -> void:
	get_tree().change_scene_to_file(GlobalScript.AllPoleScene[GlobalScript.ScientifeetDialogStep])

func VaisseauAtteint(_body:Node3D) -> void:
	get_tree().change_scene_to_file(shipScene)


func OutOfMap(_body:Node3D) -> void:
	player.character_body_3d.velocity = Vector3.ZERO
	if isFromEarth:
		player.character_body_3d.position = earthSpawnPos
		player.character_body_3d.rotation = earthSpawnRot
	else:
		player.character_body_3d.position = shipSpawnPos
		player.character_body_3d.rotation = shipSpawnRot
