extends Node3D



@export_group("Scenes Names")
@export var earthPlaceScene:String = "res://Scenes/MainScenes/definitiveScene/pole_ile.tscn"
@export var shipScene:String = "res://Scenes/MainScenes/definitiveScene/ScientifeetShip.tscn"

@export_group("Player Data")
@export var player:Player
@export var earthSpawnPos: Vector3
@export var earthSpawnRot: Vector3
@export var shipSpawnPos: Vector3
@export var shipSpawnRot: Vector3

@export_group("Respawn")
@export var respawnZAxis:float
@export var respawnHeight:float
@export var respawnXPenality:float

var isFromEarth:bool

#debug to delete
func _ready():
	init(true)

func init(fromEarth:bool):
	isFromEarth = fromEarth
	if fromEarth:
		player.character_body_3d.position = earthSpawnPos
		player.character_body_3d.rotation = earthSpawnRot
	else:
		player.character_body_3d.position = shipSpawnPos
		player.character_body_3d.rotation = shipSpawnRot
		


func coucheOzoneAtteinte(_body:Node3D) -> void:
	print("BRAVO TU AS GAGNé")
	get_tree().change_scene_to_file(earthPlaceScene)

func VaisseauAtteint(_body:Node3D) -> void:
	print("BRAVO TU AS GAGNé")
	get_tree().change_scene_to_file(shipScene)


func OutOfMap(_body:Node3D) -> void:
	print("ixi")
	player.character_body_3d.velocity = Vector3.ZERO
	if isFromEarth:
		player.position.x += respawnXPenality
		if player.character_body_3d.position.x > earthSpawnPos.x:
			player.character_body_3d.position.x = earthSpawnPos.x
		player.character_body_3d.rotation = earthSpawnRot
	else:
		player.character_body_3d.position.x -= respawnXPenality
		if player.character_body_3d.position.x < shipSpawnPos.x:
			player.character_body_3d.position.x = shipSpawnPos.x
		player.character_body_3d.rotation = shipSpawnRot
	player.character_body_3d.position.z = respawnZAxis
	player.character_body_3d.position.y = respawnHeight
