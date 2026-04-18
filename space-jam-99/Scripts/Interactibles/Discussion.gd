extends Interactable

@export var TextFile :String= "res://Assets/ScientifeetText/ScientifeetTextExample.txt"

var file:FileAccess

var NextLine :String 

var fileEnded:bool=false

func _ready():
	file = FileAccess.open(TextFile, FileAccess.READ)
	getNextLine()

func Interact(player:PlayerWithoutSkate) -> void:
	
	if !fileEnded:
		print(NextLine)
		player.hud.interact(NextLine)
		getNextLine()

func getNextLine() -> void:
	if file.eof_reached():
		print("End of file")
		fileEnded = true
		GlobalScript.asFinishedLevelTask = true
		return
	
	var lines = []
	
	while not file.eof_reached():
		var line = file.get_line()
		
		if line == "":
			break
		
		lines.append(line)
	
	NextLine = "\n".join(lines)
