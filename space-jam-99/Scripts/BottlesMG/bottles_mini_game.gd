extends Control

@export var bottleList:Array[Bottle]
var lastSelected:int=-1
var selected:int=-1
var hue:float=0.0

func _process(delta: float) -> void:
	hue += 0.7*delta
	if hue >= 1.0:
		hue = 0.0

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
		selected = -1

func check_end():
	var finished :bool=true
	for i in range(bottleList.size()):
		if !bottleList[i].isFinished():
			finished = false
	
	if finished:
		print("YOUPIIIII")
