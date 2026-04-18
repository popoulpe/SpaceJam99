extends Control

var playingMiniJeu =null

func start_miniJeux(MiniJeuxName:String)->void:
	if playingMiniJeu == null:
		var temp = load(MiniJeuxName).instantiate()
		add_child(temp)
		playingMiniJeu = temp
