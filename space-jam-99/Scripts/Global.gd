extends Node

var isFromEarth :bool = false

var asFinishedLevelTask :bool = false
var canMove :bool= true

var windowMode
var ScientifeetDialogStep :int=3

var AllScientifeetDialog: Array[String]=[
"res://Assets/ScientifeetText/dialogue1.txt",
"res://Assets/ScientifeetText/dialogue2.txt",
"res://Assets/ScientifeetText/dialogue3.txt",
"res://Assets/ScientifeetText/dialogue4.txt",
"res://Assets/ScientifeetText/FauxDialogue.txt"

]
var AllRoadsScenes: Array[String]=[
	"ne rien mettre ici, le code est un peu degueu",
	"res://Scenes/MainScenes/definitiveScene/Road1.tscn",
	"res://Scenes/MainScenes/definitiveScene/Road2.tscn",
	"res://Scenes/MainScenes/definitiveScene/Road3.tscn",
	"res://Scenes/MainScenes/definitiveScene/SceneCreditsWithShip.tscn"
]

var AllPoleScene: Array[String]=[
	"ne rien mettre ici, le code est un peu degueu",
	"res://Scenes/MainScenes/definitiveScene/pole_nord.tscn",
	"res://Scenes/MainScenes/definitiveScene/pole_ile.tscn",
	"res://Scenes/MainScenes/definitiveScene/pole_sud.tscn"
]

func showMouse():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func hideMouse():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func changeSceneToRoad(fromEarth:bool):
	GlobalScript.asFinishedLevelTask=false
	isFromEarth = fromEarth
	get_tree().change_scene_to_file(AllRoadsScenes[ScientifeetDialogStep])

func _on_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		windowMode = DisplayServer.window_get_mode()
	else:
		DisplayServer.window_set_mode(windowMode)
