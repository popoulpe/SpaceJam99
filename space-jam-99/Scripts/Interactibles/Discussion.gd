extends Interactable

var TextFile :String

var file:FileAccess

var NextLine :String 

var fileEnded:bool=false

func _ready():
	TextFile = GlobalScript.AllScientifeetDialog[GlobalScript.ScientifeetDialogStep]
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
		GlobalScript.ScientifeetDialogStep +=1
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
