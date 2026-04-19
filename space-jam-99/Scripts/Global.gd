extends Node

var isFromEarth :bool = false
var asFinishedLevelTask :bool = false
var canMove :bool= true

var ScientifeetDialogStep :int=0

var AllScientifeetDialog: Array[String]=[
"res://Assets/ScientifeetText/dialogue1V1.txt",
"res://Assets/ScientifeetText/dialogue1V1.txt",
"res://Assets/ScientifeetText/dialogue1V1.txt",
"res://Assets/ScientifeetText/dialogue1V1.txt"

]
var AllRoadsScenes: Array[String]=[
	"ne rien mettre ici, le code est un peu degueu",
	"res://Scenes/MainScenes/definitiveScene/Road1.tscn",
	"res://Scenes/MainScenes/definitiveScene/Road1.tscn",
	"res://Scenes/MainScenes/definitiveScene/Road1.tscn"
]

var AllPoleScene: Array[String]=[
	"res://Scenes/MainScenes/definitiveScene/pole_ile.tscn",
	"res://Scenes/MainScenes/definitiveScene/pole_nord.tscn",
	"res://Scenes/MainScenes/definitiveScene/pole_sud.tscn"
]

func changeSceneToRoad(fromEarth:bool):
	GlobalScript.asFinishedLevelTask=false
	isFromEarth = fromEarth
	get_tree().change_scene_to_file(AllRoadsScenes[ScientifeetDialogStep])
