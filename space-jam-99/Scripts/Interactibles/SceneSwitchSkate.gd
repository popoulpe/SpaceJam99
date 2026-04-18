extends Interactable

@export var nextLevelScene :String ="res://Scenes/MainScenes/scene_Game_01.tscn"
@export var isFromEarth :bool= true

func Interact(_player:PlayerWithoutSkate) -> void:
	get_tree().change_scene_to_file(nextLevelScene)
