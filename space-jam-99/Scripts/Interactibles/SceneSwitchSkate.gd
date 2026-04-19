extends Interactable

@export var isFromEarth :bool= true



func Interact(player:PlayerWithoutSkate) -> void:
	if GlobalScript.asFinishedLevelTask:
		GlobalScript.changeSceneToRoad(isFromEarth)
		print(GlobalScript.AllRoadsScenes[GlobalScript.ScientifeetDialogStep])
	else:
		player.hud.interact("EH ! pas si vite, il te reste des choses a faire ici")
