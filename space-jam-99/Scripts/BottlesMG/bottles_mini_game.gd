extends Control

@export var player:Node3D
@export var bottleList:Array[Bottle]
var lastSelected:int=-1
var selected:int=-1
var hue:float=0.0
@export var iLevel:int=0

func _ready():
	for i in bottleList:
		i.now_ready()

func _process(delta: float) -> void:
	hue += 0.7*delta
	if hue >= 1.0:
		hue = 0.0
	var angle: float = hue * TAU
	var r: float = (sin(angle)*0.5)+0.5
	var g:float = (sin(angle + TAU /3)*0.5)+0.5
	var b: float = (sin(angle + TAU *2/3)*0.5)+0.5
	if($TextureButton.bProgressingBar):
		$TextureButton.progressBar.tint_progress=Color(r, g, b)

func bottle_selection(id:int):
	for i in bottleList:
		i.hue = hue
	if selected < 0 && bottleList[id].actualQtt>0:
		selected = id
		bottleList[id].selection()
		lastSelected = id
	elif selected >= 0 && !bottleList[id].actualQtt >= bottleList[id].MAX_LIQUID:
		var col:Color = bottleList[selected].empty()
		bottleList[lastSelected].notSelected()
		bottleList[id].fill(col)
		selected = -1
		lastSelected = selected
		check_end()
	else:
		bottleList[lastSelected].notSelected()
		selected = -1

func check_end():
	var finished :bool=true
	for i in range(bottleList.size()):
		if !bottleList[i].isFinished():
			finished = false
	
	if finished:
		$TextureButton.visible=true
		$TextureButton.wakeup()
		$Background.bTransitionning=true
		$TextureButton.bProgressingBar=true
		if(iLevel+1>=3):
			$TextureButton/TextureRect.visible=false
			$TextureButton/TextureRect2.visible=true

func next_level():
	$TextureButton.sleep()
	$TextureButton.visible=false
	iLevel+=1
	if(iLevel>=3):
		GlobalScript.asFinishedLevelTask = true
		GlobalScript.canMove = true
		visible = false
		if(player!=null):
			player.hud_pause_menu.AudioManager._readyMusic
		print("YAHOO")
	else:
		for i in bottleList:
			i.now_ready()

func _on_texture_button_pressed() -> void:
	next_level()
