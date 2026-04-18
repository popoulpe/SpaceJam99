extends Interactable

@export var miniJeuSceneName :String = "res://Scenes/MainScenes/scene_miniGame_demineur.tscn"

func _ready():
	isMiniGame = true

func Interact(player:PlayerWithoutSkate) -> void:
	player.miniJeux.interact(miniJeuSceneName)
	
