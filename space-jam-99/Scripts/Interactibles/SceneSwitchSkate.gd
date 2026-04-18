extends Interactable

@export var nextLevelScene :String ="res://Scenes/MainScenes/scene_Game_01.tscn"
@export var isFromEarth :bool= true

func Interact(player:PlayerWithoutSkate) -> void:
	if GlobalScript.asFinishedLevelTask:
		GlobalScript.asFinishedLevelTask=false
		GlobalScript.isFromEarth = isFromEarth
		get_tree().change_scene_to_file(nextLevelScene)
	else:
		player.hud.interact("EH ! pas si vite, il te reste des choses a faire ici")
