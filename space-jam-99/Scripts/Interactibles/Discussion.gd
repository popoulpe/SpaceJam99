extends Interactable

@onready var animation_player = $animations_scientifeet/AnimationPlayer
@onready var random_animation_timer = $RandomAnimationTimer

var TextFile :String
var file:FileAccess
var NextLine :String 
var fileEnded:bool=false

var rng = RandomNumberGenerator.new()
var listAnimName:Array[String]=[
	"breakdance",
	"gagnam style",
	"head_spinning",
	"hip hop",
	"hurricane_kick",
	"spin wave combo",
	"samba",
	"hip hop_2",
	"flair_beggin",
	"hello_1",
	"hello_2",
	"goofy dance",
	"kick_double"
]

func _ready():
	TextFile = GlobalScript.AllScientifeetDialog[GlobalScript.ScientifeetDialogStep]
	file = FileAccess.open(TextFile, FileAccess.READ)
	getNextLine()
	animation_player.play("hello_2")
	random_animation_timer.start(animation_player.get_section_end_time())

func Interact(player:PlayerWithoutSkate) -> void:
	if !fileEnded:
		print(NextLine)
		player.hud.interact(NextLine)
		if(!player.hud.label_scientifeet.is_typing):
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


func _on_random_animation_timer_timeout():
	var nb : int = rng.randi_range(0,5)
	if nb == 3:
		animation_player.play(listAnimName[rng.randi_range(0, listAnimName.size())])
	else:
		animation_player.play("idle")
	random_animation_timer.start(animation_player.get_section_end_time())
